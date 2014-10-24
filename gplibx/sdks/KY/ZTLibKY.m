//
//  ZTLibKY.m
//  ZTLibKY
//
//  Created by Sail on 8/20/14.
//  Copyright (c) 2014 Giant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import "ZTLibBase+Common.h"
#import "KYSDK.h"
#import "ZTPayInfo.h"
#import "ZTSDKInfo.h"
#import "ZTRequestProxy.h"
#import "ZTConsts.h"
#import "KYMobilePay.h"
#import "ZTDeviceUtil.h"

@interface ZTKYDelegate : NSObject<KYSDKDelegate,KYMobilePayDelegate,UIAlertViewDelegate>
@end
@implementation ZTKYDelegate
- (void)UPPayPluginResult:(UNIPAYTYPE)result {
    if(result == USER_UNIPAY_SUCCESS) {
        [[ZTLibBase getInstance] finish_pay:ZTREASON_FINE withData:@""];
    }
    else {
        [[ZTLibBase getInstance] finish_pay:ZTREASON_ERROR withData:@""];
    }
}

- (void)onBillingResult:(BillingResultType)resultCode billingIndex:(NSString *)index message:(NSString *)message {
    if(resultCode == BillingResultSucceed) {
        [[ZTLibBase getInstance] finish_pay:ZTREASON_FINE withData:@""];
    }
    else {
        [[ZTLibBase getInstance] finish_pay:ZTREASON_ERROR withData:message];
    }
}

- (void)closePayCallback {
    [[ZTLibBase getInstance] finish_close:ZTWINDOW_PAY];
}

- (void)loginCallBack:(NSString *)tokenKey {
    //    BOOL isLogined = [[ZTLibBase getInstance] isLogined];
    [ZTRequestProxy requestConvertWithUID:@"" sessionID:tokenKey block:^(NSDictionary *extraDic) {
        NSString *account = extraDic[@"account_3rd"];
        [[ZTSDKInfo instance].loginJsonOfGiant setValue:account forKey:@"account_3rd"];
        //        if(isLogined) {
        //            [[ZTLibBase getInstance] finish_switch:0 withJsonObj:[ZTSDKInfo instance].loginJsonOfGiant];
        //        }else{
        [[ZTLibBase getInstance] finish_login:0 withJsonObj:[ZTSDKInfo instance].loginJsonOfGiant];
        //        }
    }];
}

- (void)quickLogCallBack:(NSString *)tokenKey {
    //    BOOL isLogined = [[ZTLibBase getInstance] isLogined];
    [ZTRequestProxy requestConvertWithUID:@"" sessionID:tokenKey block:^(NSDictionary *extraDic) {
        NSString *account = extraDic[@"account_3rd"];
        [[ZTSDKInfo instance].loginJsonOfGiant setValue:account forKey:@"account_3rd"];
        //        if(isLogined) {
        //            [[ZTLibBase getInstance] finish_switch:0 withJsonObj:[ZTSDKInfo instance].loginJsonOfGiant];
        //        }else {
        [[ZTLibBase getInstance] finish_login:0 withJsonObj:[ZTSDKInfo instance].loginJsonOfGiant];
        //        }
    }];
}

- (void)gameLoginSuc {
    
}

- (void)logOutCallBack:(NSString *)guid {
    [[ZTLibBase getInstance] finish_logout];
}

- (void)cancelUpdateCallBack {
    
}

- (void)gameLoginCallback:(NSString *)username password:(NSString *)password {
    
}

- (void)callBackForgetGamePwd {
    
}

- (void)logSendSMSCallback:(NSString *)phoneNO {
    
}

- (void)alipayCallBack:(ALIPAYRESULT)alipayresult {
    if(alipayresult == PAY_DONE) {
        [[ZTLibBase getInstance] finish_pay:ZTREASON_FINE withData:@""];
    }
    else {
        [[ZTLibBase getInstance] finish_pay:ZTREASON_ERROR withData:@""];
    }
}


@end

@implementation ZTLibBase (ThirdParty)
static ZTKYDelegate *kyDelegate = nil;
- (NSString *)getSDKVersion {
    return [NSString stringWithFormat:@"kuaiyong version %@,giant version %@",@"1.7.1",@"kuaiyong_1.0"];
}

- (void)initZTGameWithID:(NSString *)gameID gameName:(NSString *)gameName isLandscape:(BOOL)isLandScape delegate:(id <ZTListenerDelegate>)delegate {
    [self begin_init:gameID gameName:gameName isLandscape:isLandScape delegate:delegate];
    
    NSArray *array = [[UIApplication sharedApplication] windows];
    UIWindow *win = [array objectAtIndex:0];
    UIViewController *rootVC = nil;
    if ([[UIDevice currentDevice].systemVersion floatValue] < 6.0) {
        UIView *ui = [[win subviews] objectAtIndex:0];
        rootVC = (UIViewController *) [ui nextResponder];
    }
    else {
        rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    //    NSString *deviceType = [UIDevice currentDevice].model;
    UIInterfaceOrientation orient = [UIApplication sharedApplication].statusBarOrientation;
    //    UIDeviceOrientation orient = [UIDevice currentDevice].orientation;
    
    NSString *fileName = @"phone3GS_l.png";
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    CGFloat scale = [UIScreen mainScreen].scale;
    //3gs
    if (screenHeight == 480 && scale == 1 && UIInterfaceOrientationIsLandscape(orient)) {
        fileName = @"phone3GS_l.png";
    }
    else if(screenHeight == 480 && scale == 1 && UIInterfaceOrientationIsPortrait(orient)) {
        fileName = @"phone3GS_p.png";
    }
    else if(screenHeight == 480 && scale == 2 && UIInterfaceOrientationIsLandscape(orient)) {
        fileName = @"phone4S_l.png";
    }
    else if(screenHeight == 480 && scale == 2 && UIInterfaceOrientationIsPortrait(orient)) {
        fileName = @"phone4S_p.png";
    }
    else if(screenHeight == 568 && scale == 2 && UIInterfaceOrientationIsLandscape(orient)) {
        fileName = @"phone5_l.png";
    }
    else if(screenHeight == 568 && scale == 2 && UIInterfaceOrientationIsPortrait(orient)) {
        fileName = @"phone5_p.png";
    }
    else if(screenHeight == 1024 && scale == 1 && UIInterfaceOrientationIsLandscape(orient)) {
        fileName = @"pad2_l.png";
    }
    else if(screenHeight == 1024 && scale == 1 && UIInterfaceOrientationIsPortrait(orient)) {
        fileName = @"pad2_p.png";
    }
    else if(screenHeight == 1024 && scale == 2 && UIInterfaceOrientationIsLandscape(orient)) {
        fileName = @"pad3_l.png";
    }
    else if(screenHeight == 1024 && scale == 2 && UIInterfaceOrientationIsPortrait(orient)) {
        fileName = @"pad3_p.png";
    }
    UIImage *image = [UIImage imageNamed:[@"corners/" stringByAppendingString:fileName]];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [imageView setFrame:rootVC.view.bounds];
    [rootVC.view addSubview:imageView];
    [self performSelector:@selector(spalshFinish:) withObject:imageView afterDelay:3];
}

- (void)spalshFinish:(UIImageView *)imageView {
    [imageView removeFromSuperview];
    kyDelegate = [[ZTKYDelegate alloc] init];
    [[KYSDK instance] setSdkdelegate:kyDelegate];
    [[KYSDK instance] changeLogOption:KYLOG_OFFGAMENAME];
    [self finish_init:0];
}

- (void)destroyZTGame {
    [[KYSDK instance] userLogOut];
}

- (void)loginZTGame:(BOOL)autoLogin {
    if (autoLogin) {
        [[KYSDK instance] logWithLastUser];
    }
    else {
        [[KYSDK instance] showUserView];
    }
}

- (void)loginOKZTGame:(NSDictionary *)roleInfo {
    
}

- (void)postPayZTGame {
    ZTPayInfo *ztpay = [ZTPayInfo getInstance];
    NSString *productName=ztpay.productName;
    if (ztpay.count>1) {
        productName=[productName stringByAppendingFormat:@"x%d", ztpay.count];
    }
    
    NSString *payMD5=[[ZTSDKInfo instance] get:@"PAYMD5"];
    NSString *kyGameId=[[ZTSDKInfo instance] get:ZTCONFIG_APPID];
    
    NSString *price = [NSString stringWithFormat:@"%.2f", ztpay.productPrice / 100.f];
    //    [[KYSDK instance] showPayWith:ztpay.orderId fee:price game:kyGameId gamesvr:[ZTSDKInfo instance].zoneID subject:productName md5Key:payMD5 userId:@""];
    //    [[KYSDK instance] showPayWith:ztpay.orderId fee:price game:kyGameId gamesvr:@"" subject:productName md5Key:payMD5 userId:@""];
    [[KYSDK instance] showPayWith:ztpay.orderId fee:price game:kyGameId gamesvr:@"" subject:productName md5Key:payMD5 userId:@"" appScheme:[ZTSDKInfo instance].bundleID];
}


- (void)showToolbarZTGame {
    
}

- (void)hideToolbarZTGame {
    
}

- (void)userCenterZTGame {
    [[KYSDK instance] setUpUser];
}


- (unsigned long long)getPlatformID {
    return 30;
}

- (void)switchAccountZTGame {
    [[KYSDK instance] showUserView];
}


- (void)handleOpenURLZTGame:(NSURL *)url {
    
    [[AlipaySDK defaultService] processOderWithPaymentResult:url];
}

- (void)pauseZTGame {
    
}


@end
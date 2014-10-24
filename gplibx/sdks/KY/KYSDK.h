//
//  KYSDK.h
//  KYSDK
//
//  Created by MTang0589 on 14-2-24.
//  Copyright (c) 2014年 MTang0589. All rights reserved.
// sdk版本-----1.7.1

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//enum{
//    SERVICE_CHECK = -1,     //等待服务器验证
//    PAY_SUCCESS = 0,        //结果正确
//    PAY_FAILE = 1,          //结果错误
//    PAY_ERROR = 2          //验证失败
//}typedef CHECK;

enum
{
    PAY_ERROR,//支付宝回调支付出错，或者退出
    PAY_DONE//支付宝回调支付完成，结果是否正确请以服务器端通告为准
}typedef ALIPAYRESULT;

enum{
    USER_UNIPAY_SUCCESS,  //用户银联支付成功
    USER_UNIPAY_FAIL,    //用户银联支付失败
    USER_UNIPAY_CANCEL,    //用户取消银联支付
    USER_UNIPAY_ERROR    //银联没有返回结果
}typedef UNIPAYTYPE;

enum{
    KYLOG_ONGAMENAME,//显示游戏账号登录
    KYLOG_OFFGAMENAME//不显示游戏账号登录
}typedef KYLOGOPTION;

@protocol KYSDKDelegate <NSObject>
@optional
/**
 *  @method -(void)UPPayPluginResult:(UNIPAYTYPE *)result
 *  银联支付回调函数
 *  @param  result 支付结果
 */
-(void)UPPayPluginResult:(UNIPAYTYPE)result;


/**
 *  @method - (void)submitMobilePay
 *  关闭支付界面回调
 */
-(void)closePayCallback;


/**
 *  @method-(void)logCallBack:(NSString *)tokenKey
 *  用户登录回调
 *  @param  tokenKey
 **/
-(void)loginCallBack:(NSString *)tokenKey;

/**
 *  @method-(void)quickLogCallBack:(NSString *)tokenKey
 *  用户快速登录回调
 *  @param  tokenKey
 **/
-(void)quickLogCallBack:(NSString *)tokenKey;

/**
 *游戏账号登陆成功回调
 **/
-(void)gameLoginSuc;

/**
 *  @method-(void)logOutCallBack:(NSString *)guid
 *  注销方法，userLogOut该方法回调
 *  @param  guid
 **/
-(void)logOutCallBack:(NSString *)guid;

/**
 *  @method-(void)cancelUpdateCallBack
 *  游戏取消更新回调（单独使用更新时）
 **/
-(void)cancelUpdateCallBack;

/**
 *  @method-(void)gameLoginCallback:(NSString *)username password:(NSString *)password
 *  游戏账号登陆回调
 **/
-(void)gameLoginCallback:(NSString *)username password:(NSString *)password;

/**
 *-(void)callBackForgetGamePwd
 *游戏账号忘记密码回调
 **/
-(void)callBackForgetGamePwd;

/*
 *游戏账号发送验证码回调
 */
-(void)logSendSMSCallback:(NSString *)phoneNO;

//单机游戏查看订单返回结果
/**
 result: code为0时，成功 其他失败
 deal：订单信息 orderid：sdk内部订单信息 dealSeq：游戏订单信息 dealSeq
 payresult = 0支付成功，1支付失败
 map值：
 deal =     {
    dealSeq = 4108006984392363;
    fee = "1.00";
    orderid = 14040195713225139647;
    payresult = "-1";
    subject = "\U5927\U793c\U5305";
    uid = test03;
 };
 result =     {
    code = 0;
    msg = "\U8bf7\U6c42\U6210\U529f";
 };
 **/
-(void)backCheckDel:(NSMutableDictionary *)map;

/**
 *-(void)alipayCallBack
 *支付宝完成后回调
 **/
-(void)alipayCallBack:(ALIPAYRESULT)alipayresult;

@end

@interface KYSDK : NSObject
@property(assign, nonatomic)id<KYSDKDelegate> sdkdelegate;

+(id)instance;

/**
设置是否只支持iphone
 **/
-(void)setOnlySupportIPhone:(BOOL)isOnlySupportIPhone;

/**
 显示支付
 dealseq：订单号
 fee：金额
 game：http://payquery.bppstore.com上面对应ID
 gamesvr：多个通告地址的选择设置，
 md5Key：http://payquery.bppstore.com该网址对应的密匙
 appScheme：支付宝快捷支付对应的回调应用名称，要与targets-》info-》url types中的 url schemes中设置的对应
 userid:账户名，单机游戏必须传入值
 **/
-(void)showPayWith:(NSString *)dealseq fee:(NSString *)fee game:(NSString *)game gamesvr:(NSString *)gamesvr subject:(NSString *)subject md5Key:(NSString *)md5Key userId:(NSString*)userId appScheme:(NSString *)appScheme;
/**
显示用户界面
 **/
-(void)showUserView;

/**
 显示用户中心界面
 **/
-(void)setUpUser;

/**
 记住上次用户直接登录
 **/
-(void)logWithLastUser;

/**
 注销当前用户，回调游戏
 **/
-(void)userLogOut;
/**
 注销当前用户，返回登录界面
 **/
-(void)userBackToLog;
/**
 单机用户查看更新
 **/
-(void)checkUpdate;

/**
 控制登陆界面是否含有游戏账号的选项（新游戏没有老用户时，可将游戏账号关掉）
 **/
-(void)changeLogOption:(KYLOGOPTION)option;

/**
 *游戏账号登陆时，传入用户名密码
 **/
-(void)gameLoginWithArray:(NSMutableArray *)array;

/**
 *是否需要输入邀请码（如，游戏封测时需要输入邀请码,默认不需要）
 *参数isShowVerifycdKey：YES，需要邀请码。NO，不需要邀请码
 **/
-(void)verifycdKeyOption:(BOOL)isShowVerifycdKey;

/**
 *游戏账号是否错误
 */
-(void)showStateGame:(NSString *)state;

/**
 *设置是否开启游戏账号忘记密码功能
 **/
-(void)setISShowForgetGamePwd:(BOOL)isShowForgetGamePwd;

/**
 *是否开启游戏账号登录发送短息功能
 */
-(void)setISSendSMS:(BOOL)isShowSendSMS;

/**
 查看订单信息（单机游戏）
 dealseq：订单号（要与showPayWith方法传入的值一致）
 md5Key：http://payquery.bppstore.com该网址对应的密匙
 **/
-(void)checkDealseq:(NSString *)dealseq game:(NSString *)game md5Key:(NSString *)md5Key;


@end

//
//  AppDelegate.m
//  test
//
//  Created by user on 14-10-23.
//  Copyright (c) 2014年 giant. All rights reserved.
//

#import "AppDelegate.h"
#import <XcodeEditor/XCGroup.h>
#import <XcodeEditor/XCClassDefinition.h>
#import <XcodeEditor/XCProject.h>
#import <XcodeEditor/XCTarget.h>
#import <XcodeEditor/XCFrameworkDefinition.h>
#import <XcodeEditor/XCSourceFileDefinition.h>
#import <XcodeEditor/XCBundleDefinition.h>

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    XCProject* project = [[XCProject alloc] initWithFilePath:@"/Users/user/Desktop/test/test.xcodeproj"];
    XCGroup* group = [project groupWithPathFromRoot:@"test"];
//    XCClassDefinition* classDefinition = [[XCClassDefinition alloc] initWithName:@"MyNewClass"];
//    [classDefinition setHeader:@"<some-header-text>"];
//    [classDefinition setSource:@"<some-impl-text>"];
//    
//    [group addClass:classDefinition];
//    [project save];
 /*
    // 添加framework
    XCFrameworkDefinition* frameworkDefinition =
    [[XCFrameworkDefinition alloc] initWithFilePath:@"/Users/user/Desktop/test/test/Alixpay.bundle" copyToDestination:NO];
    [group addFramework:frameworkDefinition toTargets:[project targets]];
    [project save];
   
    // 添加bundle
    XCBundleDefinition *bundleDefine = [[XCBundleDefinition alloc] initWithFilePath:@"/Users/user/Desktop/Alixpay.bundle" copyToDestination:NO];
    [group addBundle:bundleDefine toTargets:[project targets] type:Bundle];
    [project save];
    

    // 添加.a
    XCBundleDefinition *aDefine = [[XCBundleDefinition alloc] initWithFilePath:@"/Users/user/Desktop/libssl.a" copyToDestination:NO];
    [group addBundle:aDefine toTargets:[project targets] type:Archive];
    [project save];
    

    // 添加.h
    XCBundleDefinition *hDefine = [[XCBundleDefinition alloc] initWithFilePath:@"/Users/user/Desktop/SomeHeader.h" copyToDestination:NO];
    [group addBundle:hDefine type:SourceCodeObjC];
    [project save];
  
    
    // 添加.m
    XCBundleDefinition *mDefine = [[XCBundleDefinition alloc] initWithFilePath:@"/Users/user/Desktop/SomeHeader.m" copyToDestination:NO];
    [group addBundle:mDefine toTargets:[project targets] type:SourceCodeObjC];
    [project save];
  
    
    // 添加plist
    XCBundleDefinition *pDefine = [[XCBundleDefinition alloc] initWithFilePath:@"/Users/user/Desktop/ztsdk_config.plist" copyToDestination:NO];
    [group addBundle:pDefine toTargets:[project targets] type:PropertyList];
    [project save];
  

    // 添加文件夹
    XCBundleDefinition *dicDefine = [[XCBundleDefinition alloc] initWithFilePath:@"/Users/user/Desktop/ztgameres" copyToDestination:NO];
    [group addBundle:dicDefine toTargets:[project targets] type:Bundle];
    [project save];
  
  */
    
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end

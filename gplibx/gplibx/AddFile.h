//
//  AddFile.h
//  gplibx
//
//  Created by user on 14-10-24.
//  Copyright (c) 2014年 giant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XcodeEditor/XCGroup.h>
#import <XcodeEditor/XCClassDefinition.h>
#import <XcodeEditor/XCProject.h>
#import <XcodeEditor/XCTarget.h>
#import <XcodeEditor/XCFrameworkDefinition.h>
#import <XcodeEditor/XCSourceFileDefinition.h>
#import <XcodeEditor/XCBundleDefinition.h>
#import <XcodeEditor/XCBuildConfiguration.h>


// 添加.m 和 编译器参数
void addMfile(NSString *file, XCProject *project, XCGroup *group, NSDictionary *params);


void addFrameworkfile(NSString *file, XCProject *project, XCGroup *group);


void addBundlefile(NSString *file, XCProject *project, XCGroup *group);

void addAfile(NSString *file, XCProject *project, XCGroup *group);


void addHfile(NSString *file, XCProject *project, XCGroup *group);

void addPlistfile(NSString *file, XCProject *project, XCGroup *group);

void addResFolder(NSString *file, XCProject *project, XCGroup *group);

void configBuild(XCProject *project, XCTarget *target, NSDictionary *configs);



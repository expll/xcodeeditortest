//
//  AddFile.h
//  gplibx
//
//  Created by user on 14-10-24.
//  Copyright (c) 2014年 giant. All rights reserved.
//

#import "AddFile.h"

// 添加.m 和 编译器参数
void addMfile(NSString *file, XCProject *project, XCGroup *group, NSDictionary *params)
{
//    id objects =  [project objects];
//    NSString *rmkey = nil;
//    for (id key in [objects allKeys]) {
//        id obj = [objects objectForKey:key];
//        NSString *filename = [[file componentsSeparatedByString:@"/"] lastObject];
//        if ([[obj objectForKey:@"name"] isEqualToString:filename]) {
//            rmkey = key;
//        }
//    }
//    if (rmkey.length > 0) {
//        [objects removeObjectForKey:rmkey];
//    }
//    for (id key in [objects allKeys]) {
//        id obj = [objects objectForKey:key];
//        if ([[obj objectForKey:@"fileRef"] isEqualToString:rmkey]) {
//            rmkey = key;
//        }
//    }
//    if (rmkey.length > 0) {
//        [objects removeObjectForKey:rmkey];
//    }
//    [project save];
    
    
    XCBundleDefinition *mDefine = [[XCBundleDefinition alloc] initWithFilePath:file copyToDestination:NO];
    [group addBundle:mDefine toTargets:[project targets] type:SourceCodeObjC params:params];
    [project save];
}


void addFrameworkfile(NSString *file, XCProject *project, XCGroup *group)
{
    id objects =  [project objects];
    NSString *rmkey = nil;
    for (id key in [objects allKeys]) {
        id obj = [objects objectForKey:key];
        NSString *filename = [[file componentsSeparatedByString:@"/"] lastObject];
        if ([[obj objectForKey:@"name"] isEqualToString:filename]) {
            rmkey = key;
        }
    }
    if (rmkey.length > 0) {
        [objects removeObjectForKey:rmkey];
    }
    for (id key in [objects allKeys]) {
        id obj = [objects objectForKey:key];
        if ([[obj objectForKey:@"fileRef"] isEqualToString:rmkey]) {
            rmkey = key;
        }
    }
    if (rmkey.length > 0) {
        [objects removeObjectForKey:rmkey];
    }
    [project save];
    
    
    XCFrameworkDefinition *fDefine = [[XCFrameworkDefinition alloc] initWithFilePath:file copyToDestination:NO];
    [group addFramework:fDefine toTargets:[project targets]];
    [project save];
    
}


void addBundlefile(NSString *file, XCProject *project, XCGroup *group)
{
    XCBundleDefinition *bundleDefine = [[XCBundleDefinition alloc] initWithFilePath:file copyToDestination:NO];
    [group addBundle:bundleDefine toTargets:[project targets] type:Bundle];
    [project save];
}

void addAfile(NSString *file, XCProject *project, XCGroup *group)
{
    XCBundleDefinition *aDefine = [[XCBundleDefinition alloc] initWithFilePath:file copyToDestination:NO];
    [group addBundle:aDefine toTargets:[project targets] type:Archive];
    [project save];
}


void addHfile(NSString *file, XCProject *project, XCGroup *group)
{
    XCBundleDefinition *hDefine = [[XCBundleDefinition alloc] initWithFilePath:file copyToDestination:NO];
    [group addBundle:hDefine type:SourceCodeObjC];
    [project save];
}

void addPlistfile(NSString *file, XCProject *project, XCGroup *group)
{
    XCBundleDefinition *pDefine = [[XCBundleDefinition alloc] initWithFilePath:file copyToDestination:NO];
    [group addBundle:pDefine toTargets:[project targets] type:PropertyList];
    [project save];
}

void addResFolder(NSString *file, XCProject *project, XCGroup *group)
{
    XCBundleDefinition *dicDefine = [[XCBundleDefinition alloc] initWithFilePath:file copyToDestination:NO];
    [group addBundle:dicDefine toTargets:[project targets] type:Bundle];
    [project save];
}


void configBuild(XCProject *project, XCTarget *target, NSDictionary *configs)
{
    for (NSString* configName in [target configurations])
    {
        for (id key in [configs allKeys]) {
            XCBuildConfiguration* configuration = [target configurationWithName:configName];
            [configuration addOrReplaceSetting:[configs objectForKey:key] forKey:key];
        }
        
    }
    [project save];
}

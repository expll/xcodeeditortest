//
//  AppDelegate.m
//  gplibx
//
//  Created by user on 14-10-24.
//  Copyright (c) 2014年 giant. All rights reserved.
//

#import "AppDelegate.h"
#import "AddFile.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    XCProject* project = [[XCProject alloc] initWithFilePath:@"/Users/user/Documents/Pros/gplibx/projects/ZTLibKY/ZTLibKY.xcodeproj"];
    
    NSArray *source = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Users/user/Documents/Pros/gplibx/sdks/KY" error:nil];
    for (NSString *src in source) {
        NSString *file = [@"/Users/user/Documents/Pros/gplibx/sdks/KY/" stringByAppendingString:src];
        
        if ([src hasSuffix:@".DS_Store"]) {
            continue;
        }
        
        if ([src hasSuffix:@".m"]) {
            XCGroup* group = [project groupWithPathFromRoot:@"ZTLibKY"];
            addMfile(file, project, group, @{@"COMPILER_FLAGS":@"-fno-objc-arc"});
            continue;
        }
        
    
        if ([src hasSuffix:@".framework"]) {
            XCGroup* group = [project groupWithPathFromRoot:@"Frameworks"];
            addFrameworkfile(file, project, group);
            continue;
        }
        
        if ([src hasSuffix:@".a"]) {
            XCGroup* group = [project groupWithPathFromRoot:@"Frameworks"];
            addAfile(file, project, group);
            continue;
        }
        
        if ([src hasSuffix:@".bundle"]) {
            XCGroup* group = [project groupWithPathFromRoot:@"ZTLibKY"];
            addBundlefile(file, project, group);
            continue;
        }
        
        if ([src rangeOfString:@"."].length == 0) {
            XCGroup* group = [project groupWithPathFromRoot:@"ZTLibKY"];
            addResFolder(file, project, group);
            continue;
        }
        
        if ([src hasSuffix:@".plist"]) {
            XCGroup* group = [project groupWithPathFromRoot:@"ZTLibKY"];
            addPlistfile(file, project, group);
            continue;
        }
        
        if ([src hasSuffix:@".h"]) {
            XCGroup* group = [project groupWithPathFromRoot:@"ZTLibKY"];
            addHfile(file, project, group);
            continue;
        }
        
    }
    
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end

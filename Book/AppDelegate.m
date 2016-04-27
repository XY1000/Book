//
//  AppDelegate.m
//  Book
//
//  Created by Apple on 16/3/21.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "AppDelegate.h"
#import "BookViewController.h"
#import "qidongViewController.h"
#import "ZhuTiNetManager.h"
#import "BookDetailNetManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//   [ZhuTiNetManager getZhuanTiDataWithZhuanTiId:1 CompletionHandle:^(id model, NSError *error) {
//       
//   }];
/** 启动界面*/
    [self startImage];
    
    return YES;
}

- (void) startImage {
    NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = infoDic[key];
    NSString *runVersion=[[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (runVersion==nil || ![runVersion isEqualToString:currentVersion] ) {
        //没运行过 或者 版本号不一致，则显示欢迎页
        
        //保存新的版本号,防止下次运行再显示欢迎页
        self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        qidongViewController *vc = [qidongViewController new];
        self.window.rootViewController = vc;
        [self.window makeKeyAndVisible];
        [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:key];
    }else{
        
        [NSThread sleepForTimeInterval:2.0];
        self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        self.window.rootViewController = [[BookViewController alloc]init];
        
        [self.window makeKeyAndVisible];
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

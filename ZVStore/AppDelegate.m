//
//  AppDelegate.m
//  ZVStore
//
//  Created by zivInfo on 17/2/16.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "AppDelegate.h"

#import "GuideViewController.h"
#import "TabBarViewController.h"

#define APP_LAUNCH_TIMES_KEY  @"app_launch_times_key"             // 记录应用程序启动次数
#define LAST_RUN_VERSION_KEY  @"last_run_version_of_application"  // 记录应用程序的版本信息

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if ([self isFirstLaunching]) {
        self.window.rootViewController = [[GuideViewController alloc] init];
    }
    else {
        self.window.rootViewController = [[TabBarViewController alloc] init];
    }
    
    return YES;
}

/*
 * 是否为版本升级后的第一次打开程序
 */
- (BOOL)isFirstLaunching
{
    // 从plist文件中取出版本号
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    // 取出NSUserDefaults中的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastRunVersion = [defaults objectForKey:LAST_RUN_VERSION_KEY];
    
    // 应用程序全新安装，返回yes进入引导页面
    if (!lastRunVersion) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        [defaults setObject:[NSNumber numberWithInt:1] forKey:APP_LAUNCH_TIMES_KEY];
        return YES;
    }
    
    // 应用程序升级安装
    if (![lastRunVersion isEqualToString:currentVersion]) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        // 重置应用程序启动次数计数器以及打分提醒设置
        [defaults setObject:[NSNumber numberWithInt:1] forKey:APP_LAUNCH_TIMES_KEY];
        [defaults synchronize];
        return YES;
    }
    
    // 应用程序启动次数+1
    int appLaunchTimes = [[defaults objectForKey:APP_LAUNCH_TIMES_KEY] intValue];
    [defaults setObject:[NSNumber numberWithInt:++appLaunchTimes] forKey:APP_LAUNCH_TIMES_KEY];
    [defaults synchronize];
    
    // NSLog(@"启动次数%d",appLaunchTimes);
    
    return NO;
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

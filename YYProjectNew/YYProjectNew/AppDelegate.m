//
//  AppDelegate.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/17.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "AppDelegate.h"
#import "YYNetwork.h"
#import "YYRequestConst.h"

@interface AppDelegate ()<YYServiceFactoryDataSource>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*说明：资源文件目录     */
    NSBundle *bundle = [NSBundle mainBundle];
    DLog(@"%@",bundle);
    
    /*说明：documents文件目录      */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    DLog(@"%@",paths);
    
    [YYServiceFactory sharedInstance].dataSource = self;
    
    return YES;
}

- (NSDictionary<NSString *,NSString *> *)serviceInfos {
    
    return @{YYTestServiceV1:@"YYTestService"};
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





@end

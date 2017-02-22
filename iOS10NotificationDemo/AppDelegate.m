//
//  AppDelegate.m
//  iOS10NotificationDemo
//
//  Created by Decade on 2017/2/20.
//  Copyright © 2017年 YinjianChen. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self registerNotification:application];
    
 
    
    
    return YES;
}

- (void)registerNotification:(UIApplication *)application{
    // register notification
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        // iOS 10
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // click allow
                NSLog(@"注册通知成功");
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    //NSLog(@"%@", settings);
                }];
            } else {
                // don't allow
                NSLog(@"注册通知失败");
            }
        }];
    }else{
        //  //iOS8 - iOS10
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
    }
    
    [application registerForRemoteNotifications];
    
}
#pragma mark - device token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{

    NSString *deviceString = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    deviceString = [deviceString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"deviceToken %@",deviceString);

    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"[DeviceToken Error]:%@\n",error.description);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{

    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {

        NSLog(@"iOS10 收到远程通知");
        
    }else {

        NSLog(@"iOS10 收到本地通知:");
    }

    completionHandler(UNNotificationPresentationOptionBadge|
                      UNNotificationPresentationOptionSound|
                      UNNotificationPresentationOptionAlert);
    
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

//{
//    "aps":{
//        "alert" : {
//            "title" : "title",
//            "subtitle" : "Subtitle",
//            "body" : "body"
//        },
//        "sound" : "default",
//        "badge" : "1",
//        "mutable-content" : "1",
//        "category" : "category"
//    },
//    "image" : "http://pic9.nipic.com/20100906/1295091_134639124058_2.jpg",
//    "type" : "scene",
//    "id" : "1000"
//}

@end

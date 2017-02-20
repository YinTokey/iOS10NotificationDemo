//
//  ViewController.m
//  iOS10NotificationDemo
//
//  Created by Decade on 2017/2/20.
//  Copyright © 2017年 YinjianChen. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
@interface ViewController ()<UNUserNotificationCenterDelegate>

@property (nonatomic, strong) UNMutableNotificationContent *notificationContent;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _notificationContent = [[UNMutableNotificationContent alloc]init];
    
    [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)imageClick:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"wallpaper" ofType:@"png"];
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"imgAttachment" URL:[NSURL fileURLWithPath:path] options:nil error:nil];
    if(attachment){
        self.notificationContent.attachments = @[attachment];
    }

    [self createLocalNotificationWithContent:_notificationContent];
}

- (IBAction)soundClick:(id)sender {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"audio" ofType:@"Mp3"];
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"audioAttachment" URL:[NSURL fileURLWithPath:path] options:nil error:nil];
    if(attachment){
        self.notificationContent.attachments = @[attachment];
    }
    
    [self createLocalNotificationWithContent:_notificationContent];
    
}
- (IBAction)videoClick:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"video2" ofType:@"mp4"];
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"videoAttachment" URL:[NSURL fileURLWithPath:path] options:nil error:nil];
    if(attachment){
        self.notificationContent.attachments = @[attachment];
    }
    
    [self createLocalNotificationWithContent:_notificationContent];
}


- (void)createLocalNotificationWithContent:(UNMutableNotificationContent *)content{

    content.title = @"title";
    content.subtitle = @"subtitle";
    content.body = @"body";
    content.badge = @1;
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    
    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2.0 repeats:NO];
    NSString *requertID = @"requestID";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requertID content:content trigger:trigger1];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {

    }];
    
    
}

#pragma mark delegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    completionHandler(UNNotificationPresentationOptionBadge|
                      UNNotificationPresentationOptionSound|
                      UNNotificationPresentationOptionAlert);
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {


     completionHandler();
}

@end

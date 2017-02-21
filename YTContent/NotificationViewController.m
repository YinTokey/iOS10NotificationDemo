//
//  NotificationViewController.m
//  YTContent
//
//  Created by Decade on 2017/2/20.
//  Copyright © 2017年 YinjianChen. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.body;
    UNNotificationContent * content = notification.request.content;
    UNNotificationAttachment * attachment = content.attachments.firstObject;
    if (attachment.URL.startAccessingSecurityScopedResource) {
        self.imgV.image = [UIImage imageWithContentsOfFile:attachment.URL.path];
    }
}

@end

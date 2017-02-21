//
//  NotificationService.m
//  pushService
//
//  Created by Decade on 2017/2/21.
//  Copyright © 2017年 YinjianChen. All rights reserved.
//

#import "NotificationService.h"
#import <UIKit/UIKit.h>
@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    NSString * imageUrlStr = [request.content.userInfo objectForKey:@"image"];
    //下载图片
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlStr]];
    UIImage * image = [UIImage imageWithData:data];
    //保存到本地
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectoryPath = [paths firstObject];
    NSString * localPath = [documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", @"notificationImage", @"png"]];
    [UIImagePNGRepresentation(image) writeToFile:localPath options:NSAtomicWrite error:nil];
    
    if (localPath && ![localPath isEqualToString:@""]) {
        UNNotificationAttachment * attachment = [UNNotificationAttachment attachmentWithIdentifier:@"image" URL:[NSURL fileURLWithPath:localPath] options:nil error:nil];
        if (attachment) {
            self.bestAttemptContent.attachments = @[attachment];
        }
    }
    self.contentHandler(self.bestAttemptContent);
    
}



- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end

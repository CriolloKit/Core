//
//  CRPushNotificationConfigurator.h
//  Core
//
//  Created by TheSooth on 9/19/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CRPushNotificationsConfigurator <NSObject>

- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (UIRemoteNotificationType)notificationTypes;

@optional

- (void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

@end

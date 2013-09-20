//
//  CRAppConfiguration.h
//  Core
//
//  Created by TheSooth on 9/19/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CRAppearanceConfigurator;
@protocol CRPushNotificationsConfigurator;
@protocol CRPushNotificationReceiver;
@protocol CRLocalNotificationReceiver;
@protocol CRAppLifeConfigurator;
@protocol CRAppURLHandler;
@protocol CRAppRestorationStateConfigurator;
@protocol CRAppMemoryWarrningConfigurator;
@protocol CRAppWindowOrientationConfigurator;
@protocol CRStatusBarOrientationHandler;

@protocol CRAppConfiguration <NSObject>

@optional

- (id <CRAppearanceConfigurator>)appearanceConfigurator;

- (id <CRPushNotificationsConfigurator>)pushNotificationsConfigurator;

- (id <CRPushNotificationReceiver>)pushNotificationReceiver;

- (id <CRLocalNotificationReceiver>)localNotificationReceiver;

- (id <CRAppLifeConfigurator>)appLifeConfigurator;

- (id <CRAppURLHandler>)urlHandler;

- (id <CRAppRestorationStateConfigurator>)restorationConfigurator;

- (id <CRAppMemoryWarrningConfigurator>)appMemoryWarrningConfigurator;

- (id <CRAppWindowOrientationConfigurator>)windowOrientationConfigurator;

- (id <CRStatusBarOrientationHandler>)statusBarOrientationHandler;

@end

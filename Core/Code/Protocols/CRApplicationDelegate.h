//
//  CRApplicationDelegate.h
//  Core
//
//  Created by Vladimir Shevchenko on 20.09.13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRAppearanceConfigurator.h"
#import "CRPushNotificationsConfigurator.h"
#import "CRPushNotificationReceiver.h"
#import "CRLocalNotificationReceiver.h"
#import "CRAppLifeConfigurator.h"
#import "CRAppURLHandler.h"
#import "CRAppRestorationStateConfigurator.h"
#import "CRAppMemoryWarrningConfigurator.h"
#import "CRAppWindowOrientationConfigurator.h"
#import "CRStatusBarOrientationHandler.h"

@protocol CRApplicationDelegate <NSObject>

@property (nonatomic, strong) id <CRAppearanceConfigurator> appearanceConfigurator;
@property (nonatomic, strong) id <CRPushNotificationsConfigurator> pushNotificationsConfigurator;
@property (nonatomic, strong) id <CRPushNotificationReceiver> pushNotificationReceiver;
@property (nonatomic, strong) id <CRLocalNotificationReceiver> localNotificationReceiver;
@property (nonatomic, strong) id <CRAppLifeConfigurator> appLifeCycleConfigurator;
@property (nonatomic, strong) id <CRAppURLHandler> urlHandler;
@property (nonatomic, strong) id <CRAppRestorationStateConfigurator> restorationConfigurator;
@property (nonatomic, strong) id <CRAppMemoryWarrningConfigurator> appMemoryWarrningConfigurator;
@property (nonatomic, strong) id <CRAppWindowOrientationConfigurator> windowOrientationConfigurator;
@property (nonatomic, strong) id <CRStatusBarOrientationHandler> statusBarOrientationHandler;


@end

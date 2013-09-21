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
#import "CRRootTransaction.h"

@protocol CRApplicationDelegate <NSObject>

@property (nonatomic, strong) id <CRAppearanceConfigurator> ioc_appearanceConfigurator;
@property (nonatomic, strong) id <CRPushNotificationsConfigurator> ioc_pushNotificationsConfigurator;
@property (nonatomic, strong) id <CRPushNotificationReceiver> ioc_pushNotificationReceiver;
@property (nonatomic, strong) id <CRLocalNotificationReceiver> ioc_localNotificationReceiver;
@property (nonatomic, strong) id <CRAppLifeConfigurator> ioc_appLifeCycleConfigurator;
@property (nonatomic, strong) id <CRAppURLHandler> ioc_urlHandler;
@property (nonatomic, strong) id <CRAppRestorationStateConfigurator> ioc_restorationConfigurator;
@property (nonatomic, strong) id <CRAppMemoryWarrningConfigurator> ioc_appMemoryWarrningConfigurator;
@property (nonatomic, strong) id <CRAppWindowOrientationConfigurator> ioc_windowOrientationConfigurator;
@property (nonatomic, strong) id <CRStatusBarOrientationHandler> ioc_statusBarOrientationHandler;
@property (nonatomic, strong) id <CRRootTransaction> ioc_rootTranscation;


@end

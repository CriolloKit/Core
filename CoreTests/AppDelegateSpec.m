//
//  AppDelegateSpec.m
//  Core
//
//  Created by Vladimir Shevchenko on 20.09.13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CRAppDelegate.h"

SPEC_BEGIN(AppDelegateSpec)

describe(@"AppDelegate", ^{
    
    __block CRAppDelegate <CRApplicationDelegate> *appDelegate;
    __block UIApplication *application = [KWMock mockForClass:[UIApplication class]];
    
    
    beforeEach(^{
        appDelegate = (CRAppDelegate <CRApplicationDelegate> *)[CRAppDelegate new];
        
    });
    
    it(@"Should conform to CRPushNotificationsConfigurator protocol", ^{
        KWMock <CRPushNotificationsConfigurator> *mock = [KWMock mockForProtocol:@protocol(CRPushNotificationsConfigurator)];
        
        UIApplication *appMock = [KWMock mockForClass:[UIApplication class]];
        
        NSNumber *notifiTypes = @(10);
        
        [appMock stub:@selector(registerForRemoteNotificationTypes:) withBlock:^id(NSArray *params) {
            [[theValue([params[0] integerValue]) should] equal:theValue(notifiTypes.integerValue)
             ];
            [appDelegate application:nil didRegisterForRemoteNotificationsWithDeviceToken:[@"" dataUsingEncoding:NSUTF8StringEncoding]];
            
            return nil;
        }];
        
        [mock stub:@selector(didRegisterForRemoteNotificationsWithDeviceToken:) withBlock:^id(NSArray *params) {
            [[params[0] should] beNonNil];
            return nil;
        }];
        
        [mock stub:@selector(notificationTypes) withBlock:^id(NSArray *params) {
            NSLog(@"executing notificationTypes method");
            return notifiTypes;
        }];
        
        [appMock registerForRemoteNotificationTypes:notifiTypes.integerValue];
    });
    
    it(@"Should conform to CRPushNotificationReceiver protocol", ^{
        
        NSDictionary *testDictionary = @{@"key" : @"value"};
        
        KWMock <CRPushNotificationReceiver> *mock = [KWMock mockForProtocol:@protocol(CRPushNotificationReceiver)];
        
        appDelegate.ioc_pushNotificationReceiver = mock;
        
        [mock stub:@selector(didReceiveRemoteNotification:) withBlock:^id(NSArray *params) {
            [[params[0] should] beKindOfClass:[NSDictionary class]];
            [[params[0] should] equal:testDictionary];
            
            return nil;
        }];
       
        [appDelegate application:nil didReceiveRemoteNotification:testDictionary];
    });
    
    it(@"Should conform to CRLocalNotificationReceiver protocol", ^{
        
        UILocalNotification *notofocation = [UILocalNotification new];
        
        KWMock <CRLocalNotificationReceiver> *mock = [KWMock mockForProtocol:@protocol(CRLocalNotificationReceiver)];
        
        appDelegate.ioc_localNotificationReceiver = mock;
        
        [mock stub:@selector(didReceiveLocalNotification:) withBlock:^id(NSArray *params) {
            [[params[0] should] beKindOfClass:[UILocalNotification class]];
            [[params[0] should] equal:notofocation];
            
            return nil;
        }];
        
        [appDelegate application:nil didReceiveLocalNotification:notofocation];
    });
    
    it(@"Should conform to CRAppLifeConfigurator protocol", ^{

        KWMock <CRAppLifeConfigurator> *mock = [KWMock mockForProtocol:@protocol(CRAppLifeConfigurator)];
        
        appDelegate.ioc_appLifeCycleConfigurator = mock;
        
        SEL selectors[] = {
            @selector(applicationDidBecomeActive:),
            @selector(applicationWillResignActive:),
            @selector(applicationDidEnterBackground:),
            @selector(applicationWillEnterForeground:),
            @selector(applicationWillTerminate:)
        };
        
        NSInteger length = sizeof(selectors) / sizeof(selectors[0]);
        for (NSInteger i = 0; i < length; i++) {
            [mock stub:selectors[i] withBlock:^id(NSArray *params) {
                [[params[0] should] equal:application];
                return nil;
            }];

        }
        
        for (NSInteger i = 0; i < length; i++) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [appDelegate performSelector:selectors[i] withObject:application];
#pragma clang diagnostic pop
        }        
    });
    
    it(@"Should conform to CRAppURLHandler protocol", ^{
        
        NSURL *url = [NSURL URLWithString:@"http://example.com"];
        
        KWMock *mock = [KWMock mockForProtocol:@protocol(CRAppURLHandler)];
        
        [mock stub:@selector(handleOpenURL:) withBlock:^id(NSArray *params) {
            [[params[0] should] equal:url];
            return nil;
        }];
        
        [mock stub:@selector(openURL:sourceApplication:annotation:) withBlock:^id(NSArray *params) {
            [[params should] haveCountOf:3]; // why 3? - becouse there is 3 arguments
            return nil;
        }];
        
        [appDelegate application:application handleOpenURL:url];
        [appDelegate application:application openURL:url sourceApplication:@"SourceApplication" annotation:@"Annotation"];
        
    });
    
    it(@"Should conform to CRAppRestorationStateConfigurator protocol", ^{
        KWMock <CRAppRestorationStateConfigurator> *mock = [KWMock mockForProtocol:@protocol(CRAppRestorationStateConfigurator)];
        
        __block SEL selectors[] = {
            @selector(viewControllerWithIdentifierPath:coder:),
            @selector(shouldSaveApplicationState:),
            @selector(shouldRestoreApplicationState:),
            @selector(willEncodeRestorableStateWithCoder:),
            @selector(didDecodeRestorableStateWithCoder:)
        };
        
        NSInteger length = sizeof(selectors) / sizeof(selectors[0]);
        
        for (NSInteger i = 0; i < length; i++) {
            
            SEL selector = selectors[i];
            NSString *selectorName = NSStringFromSelector(selector);
            
            [mock stub:selector withBlock:^id(NSArray *params) {
                NSLog(@"executing selector : %@", selectorName);
                return nil;
            }];
        }
        
        [appDelegate application:application viewControllerWithRestorationIdentifierPath:nil coder:nil];
        [appDelegate application:application shouldSaveApplicationState:nil];
        [appDelegate application:application shouldRestoreApplicationState:nil];
        [appDelegate application:application willEncodeRestorableStateWithCoder:nil];
        [appDelegate application:application didDecodeRestorableStateWithCoder:nil];
    });
    
    it(@"Should conform to CRAppMemoryWarrningConfigurator protocol", ^{
        KWMock *mock = [KWMock mockForProtocol:@protocol(CRAppMemoryWarrningConfigurator)];
        
        [mock stub:@selector(didReceiveMemoryWarning)];
        
        [appDelegate applicationDidReceiveMemoryWarning:nil];
    });
    
    it(@"Should conform to CRAppWindowOrientationConfigurator", ^{
        KWMock <CRAppWindowOrientationConfigurator> *mock = [KWMock mockForProtocol:@protocol(CRAppWindowOrientationConfigurator)];
        
        appDelegate.ioc_windowOrientationConfigurator = mock;
        
        [mock stub:@selector(supportedInterfaceOrientationsForWindow:)];
        
        [appDelegate application:nil supportedInterfaceOrientationsForWindow:nil];
    });
    
    it(@"Should conform to CRStatusBarOrientationHandler", ^{
        KWMock <CRStatusBarOrientationHandler> *mock = [KWMock mockForProtocol:@protocol(CRStatusBarOrientationHandler)];
        
        appDelegate.ioc_statusBarOrientationHandler = mock;
        
        SEL selectors[] = {
            @selector(willChangeStatusBarOrientation:duration:),
            @selector(didChangeStatusBarOrientation:),
            @selector(willChangeStatusBarFrame:),
            @selector(didChangeStatusBarFrame:)
        };
        
        NSInteger lenght = sizeof(selectors) / sizeof(selectors[0]);
        
        for (NSInteger i = 0; i < lenght; i++) {
            [mock stub:selectors[i]];
        }
        
        [appDelegate application:nil willChangeStatusBarOrientation:0 duration:0];
        [appDelegate application:nil didChangeStatusBarOrientation:0];
        
        [appDelegate application:nil willChangeStatusBarFrame:CGRectZero];
        [appDelegate application:nil didChangeStatusBarFrame:CGRectZero];
    });
});

SPEC_END
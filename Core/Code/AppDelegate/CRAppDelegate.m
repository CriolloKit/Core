//
//  CRAppDelegate.m
//  Core
//
//  Created by TheSooth on 9/19/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRAppDelegate.h"
#import "CRAppConfiguration.h"
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

@interface CRAppDelegate ()

@property (nonatomic, strong) id <CRAppConfiguration> configurator;

@end

@implementation CRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self setupAppearance];
    [self setupAPNS];
    
    return YES;
}

- (void)setupAppearance
{
    id <CRAppearanceConfigurator> appearanceConfigurator = [self.configurator appearanceConfigurator];
    [appearanceConfigurator setup];
}

#pragma mark -
#pragma mark - Push Notifications Configuration

- (void)setupAPNS
{
    id <CRPushNotificationsConfigurator> pushNotificationsConfigurator = self.configurator.pushNotificationsConfigurator;
    
    if (pushNotificationsConfigurator) {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:pushNotificationsConfigurator.notificationTypes];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    id <CRPushNotificationsConfigurator> pushNotificationsConfigurator = [self.configurator pushNotificationsConfigurator];
    
    SEL didRegisterSelector = @selector(didRegisterForRemoteNotificationsWithDeviceToken:);
    
    [self configurator:pushNotificationsConfigurator performSelector:didRegisterSelector withObject:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    id <CRPushNotificationsConfigurator> pushNotificationsConfigurator = [self.configurator pushNotificationsConfigurator];
    
    SEL didFailRegisterSelector = @selector(didFailToRegisterForRemoteNotificationsWithError:);
    
    [self configurator:pushNotificationsConfigurator performSelector:didFailRegisterSelector withObject:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    id <CRPushNotificationReceiver> pushNotificationsReceiver = [self.configurator pushNotificationReceiver];
    
    SEL didReceiveRemoteNotificationSelector = @selector(didReceiveRemoteNotification:);
    
    [self configurator:pushNotificationsReceiver performSelector:didReceiveRemoteNotificationSelector withObject:userInfo];
}

#pragma mark -
#pragma mark - Local Notifications Configuration

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    id <CRLocalNotificationReceiver> localNotificationsReceiver = [self.configurator localNotificationReceiver];
    
    SEL didReceiveLocalNotificationSelector = @selector(didReceiveLocalNotification:);
    
    [self configurator:localNotificationsReceiver performSelector:didReceiveLocalNotificationSelector withObject:notification];
}

#pragma mark -
#pragma mark - Application Lifetime Configuration

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    id <CRAppLifeConfigurator> appLifeConfigurator =  self.configurator.appLifeConfigurator;
    
    [self configurator:appLifeConfigurator performSelector:_cmd withObject:application];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    id <CRAppLifeConfigurator> appLifeConfigurator =  self.configurator.appLifeConfigurator;
    
    [self configurator:appLifeConfigurator performSelector:_cmd withObject:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    id <CRAppLifeConfigurator> appLifeConfigurator =  self.configurator.appLifeConfigurator;
    
    [self configurator:appLifeConfigurator performSelector:_cmd withObject:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    id <CRAppLifeConfigurator> appLifeConfigurator =  self.configurator.appLifeConfigurator;
    
    [self configurator:appLifeConfigurator performSelector:_cmd withObject:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    id <CRAppLifeConfigurator> appLifeConfigurator =  self.configurator.appLifeConfigurator;
    
    [self configurator:appLifeConfigurator performSelector:_cmd withObject:application];
}

#pragma mark -
#pragma mark - Application URL Handling

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    id <CRAppURLHandler> urlHandler = [self.configurator urlHandler];
    
    return [urlHandler handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    id <CRAppURLHandler> urlHandler = [self.configurator urlHandler];
    
    SEL openURLSelector = @selector(openURL:sourceApplication:annotation:);
    
    if ([urlHandler respondsToSelector:openURLSelector]) {
        return [urlHandler openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
    
    return NO;
}

#pragma mark -
#pragma mark - Application Restoration Configuration

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents
                            coder:(NSCoder *)coder
{
    id <CRAppRestorationStateConfigurator> restorationStateConfigurator = [self.configurator restorationConfigurator];
    
    SEL viewControllerWithRestorationIdentifierPathSelector = @selector(viewControllerWithIdentifierPath:coder:);
    
    if ([restorationStateConfigurator respondsToSelector:viewControllerWithRestorationIdentifierPathSelector]) {
      return [restorationStateConfigurator viewControllerWithIdentifierPath:identifierComponents coder:coder];
    }
    
    return nil;
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
    id <CRAppRestorationStateConfigurator> restorationStateConfigurator = [self.configurator restorationConfigurator];

    SEL shouldSaveApplicationStateSelector = @selector(shouldSaveApplicationState:);
    
    if ([restorationStateConfigurator respondsToSelector:shouldSaveApplicationStateSelector]) {
        return [restorationStateConfigurator shouldSaveApplicationState:coder];
    }
    
    return NO;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
    id <CRAppRestorationStateConfigurator> restorationStateConfigurator = [self.configurator restorationConfigurator];
    
    SEL shouldRestoreApplicationStateSelector = @selector(shouldRestoreApplicationState:);
    
    if ([restorationStateConfigurator respondsToSelector:shouldRestoreApplicationStateSelector]) {
        [restorationStateConfigurator shouldRestoreApplicationState:coder];
    }
    
    return NO;
}

- (void)application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder
{
    id <CRAppRestorationStateConfigurator> restorationStateConfigurator = [self.configurator restorationConfigurator];
    
    SEL willEndoceRestorableStateSelector = @selector(willEncodeRestorableStateWithCoder:);
    
    [self configurator:restorationStateConfigurator performSelector:willEndoceRestorableStateSelector withObject:coder];
}

- (void)application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder
{
    id <CRAppRestorationStateConfigurator> restorationStateConfigurator = [self.configurator restorationConfigurator];
    
    SEL didDecodeRestorableStateSelector = @selector(didDecodeRestorableStateWithCoder:);
    
    [self configurator:restorationStateConfigurator performSelector:didDecodeRestorableStateSelector withObject:coder];
}

#pragma mark -
#pragma mark - Application Memory Warrning Configuratror

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    id <CRAppMemoryWarrningConfigurator> memoryWarrningConfigurator = [self.configurator appMemoryWarrningConfigurator];
    
    [self configurator:memoryWarrningConfigurator performSelector:_cmd];
}

#pragma mark -
#pragma mark - Application Window orientation Configurator

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    id <CRAppWindowOrientationConfigurator> windowOrientationConfigurator = [self.configurator windowOrientationConfigurator];
    
    if ([windowOrientationConfigurator respondsToSelector:@selector(supportedInterfaceOrientationsForWindow:)]) {
        return [windowOrientationConfigurator supportedInterfaceOrientationsForWindow:window];
    }
    
    return 0;
}

#pragma mark -
#pragma mark - StatusBar Orientation Handler

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration
{
    id <CRStatusBarOrientationHandler> statusBarOrientationHandler = [self.configurator statusBarOrientationHandler];
    
    SEL willChangeStatusBarOrientationSelector = @selector(willChangeStatusBarOrientation:duration:);
    
    if ([statusBarOrientationHandler respondsToSelector:willChangeStatusBarOrientationSelector]) {
        [statusBarOrientationHandler willChangeStatusBarOrientation:newStatusBarOrientation duration:duration];
    }
}

- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation
{
    id <CRStatusBarOrientationHandler> statusBarOrientationHandler = [self.configurator statusBarOrientationHandler];
    
    SEL didChangeStatusBarOrientationSelector = @selector(didChangeStatusBarOrientation:);
    
    if ([statusBarOrientationHandler respondsToSelector:didChangeStatusBarOrientationSelector]) {
        [statusBarOrientationHandler didChangeStatusBarOrientation:oldStatusBarOrientation];
    }
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame
{
    id <CRStatusBarOrientationHandler> statusBarOrientationHandler = [self.configurator statusBarOrientationHandler];
    
    SEL willChangeStatusBarFrameSelector = @selector(willChangeStatusBarFrame:);
    
    if ([statusBarOrientationHandler respondsToSelector:willChangeStatusBarFrameSelector]) {
        [statusBarOrientationHandler willChangeStatusBarFrame:newStatusBarFrame];
    }
}

- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame
{
    id <CRStatusBarOrientationHandler> statusBarOrientationHandler = [self.configurator statusBarOrientationHandler];
    
    SEL didChangeStatusBarFrameSelector = @selector(didChangeStatusBarFrame:);
    
    if ([statusBarOrientationHandler respondsToSelector:didChangeStatusBarFrameSelector]) {
        [statusBarOrientationHandler didChangeStatusBarFrame:oldStatusBarFrame];
    }
    
}

#pragma mark -
#pragma mark - Helper Methods

- (void)configurator:(id)aConfigurator performSelector:(SEL)aSelector withObject:(id)aObject
{
    if ([aConfigurator respondsToSelector:aSelector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [aConfigurator performSelector:aSelector withObject:aObject];
    }
#pragma clang diagnostic pop
}

- (void)configurator:(id)aConfigurator performSelector:(SEL)aSelector
{
    if ([aConfigurator respondsToSelector:aSelector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [aConfigurator performSelector:aSelector];
    }
#pragma clang diagnostic pop
}

@end

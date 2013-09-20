//
//  CRAppDelegate.m
//  Core
//
//  Created by TheSooth on 9/19/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRAppDelegate.h"

@interface CRAppDelegate () <CRApplicationDelegate>

@end

@implementation CRAppDelegate

@synthesize appearanceConfigurator;
@synthesize pushNotificationsConfigurator;
@synthesize pushNotificationReceiver;
@synthesize localNotificationReceiver;
@synthesize appLifeCycleConfigurator;
@synthesize urlHandler;
@synthesize restorationConfigurator;
@synthesize appMemoryWarrningConfigurator;
@synthesize windowOrientationConfigurator;
@synthesize statusBarOrientationHandler;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self setupAppearance];
    [self setupAPNS];
    
    return YES;
}

- (void)setupAppearance
{
    [self.appearanceConfigurator setup];
}

#pragma mark -
#pragma mark - Push Notifications Configuration

- (void)setupAPNS
{
    if (self.pushNotificationsConfigurator) {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:self.pushNotificationsConfigurator.notificationTypes];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    SEL didRegisterSelector = @selector(didRegisterForRemoteNotificationsWithDeviceToken:);
    
    [self configurator:self.pushNotificationsConfigurator performSelector:didRegisterSelector withObject:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    SEL didFailRegisterSelector = @selector(didFailToRegisterForRemoteNotificationsWithError:);
    
    [self configurator:self.pushNotificationsConfigurator performSelector:didFailRegisterSelector withObject:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    SEL didReceiveRemoteNotificationSelector = @selector(didReceiveRemoteNotification:);
    
    [self configurator:self.pushNotificationReceiver performSelector:didReceiveRemoteNotificationSelector withObject:userInfo];
}

#pragma mark -
#pragma mark - Local Notifications Configuration

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    SEL didReceiveLocalNotificationSelector = @selector(didReceiveLocalNotification:);
    
    [self configurator:self.localNotificationReceiver performSelector:didReceiveLocalNotificationSelector withObject:notification];
}

#pragma mark -
#pragma mark - Application Lifetime Configuration

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self configurator:self.appLifeCycleConfigurator performSelector:_cmd withObject:application];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [self configurator:self.appLifeCycleConfigurator performSelector:_cmd withObject:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self configurator:self.appLifeCycleConfigurator performSelector:_cmd withObject:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self configurator:self.appLifeCycleConfigurator performSelector:_cmd withObject:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self configurator:self.appLifeCycleConfigurator performSelector:_cmd withObject:application];
}

#pragma mark -
#pragma mark - Application URL Handling

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self.urlHandler handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    SEL openURLSelector = @selector(openURL:sourceApplication:annotation:);
    
    if ([self.urlHandler respondsToSelector:openURLSelector]) {
        return [self.urlHandler openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
    
    return NO;
}

#pragma mark -
#pragma mark - Application Restoration Configuration

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents
                            coder:(NSCoder *)coder
{
    SEL viewControllerWithRestorationIdentifierPathSelector = @selector(viewControllerWithIdentifierPath:coder:);
    
    if ([self.restorationConfigurator respondsToSelector:viewControllerWithRestorationIdentifierPathSelector]) {
      return [self.restorationConfigurator viewControllerWithIdentifierPath:identifierComponents coder:coder];
    }
    
    return nil;
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
    SEL shouldSaveApplicationStateSelector = @selector(shouldSaveApplicationState:);
    
    if ([self.restorationConfigurator respondsToSelector:shouldSaveApplicationStateSelector]) {
        return [self.restorationConfigurator shouldSaveApplicationState:coder];
    }
    
    return NO;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
    SEL shouldRestoreApplicationStateSelector = @selector(shouldRestoreApplicationState:);
    
    if ([self.restorationConfigurator respondsToSelector:shouldRestoreApplicationStateSelector]) {
        [self.restorationConfigurator shouldRestoreApplicationState:coder];
    }
    
    return NO;
}

- (void)application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder
{
    SEL willEndoceRestorableStateSelector = @selector(willEncodeRestorableStateWithCoder:);
    
    [self configurator:self.restorationConfigurator performSelector:willEndoceRestorableStateSelector withObject:coder];
}

- (void)application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder
{
    SEL didDecodeRestorableStateSelector = @selector(didDecodeRestorableStateWithCoder:);
    
    [self configurator:self.restorationConfigurator performSelector:didDecodeRestorableStateSelector withObject:coder];
}

#pragma mark -
#pragma mark - Application Memory Warrning Configuratror

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [self configurator:self.appMemoryWarrningConfigurator performSelector:_cmd];
}

#pragma mark -
#pragma mark - Application Window orientation Configurator

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if ([self.windowOrientationConfigurator respondsToSelector:@selector(supportedInterfaceOrientationsForWindow:)]) {
        return [self.windowOrientationConfigurator supportedInterfaceOrientationsForWindow:window];
    }
    
    return 0;
}

#pragma mark -
#pragma mark - StatusBar Orientation Handler

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration
{
    SEL willChangeStatusBarOrientationSelector = @selector(willChangeStatusBarOrientation:duration:);
    
    if ([self.statusBarOrientationHandler respondsToSelector:willChangeStatusBarOrientationSelector]) {
        [self.statusBarOrientationHandler willChangeStatusBarOrientation:newStatusBarOrientation duration:duration];
    }
}

- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation
{
    SEL didChangeStatusBarOrientationSelector = @selector(didChangeStatusBarOrientation:);
    
    if ([self.statusBarOrientationHandler respondsToSelector:didChangeStatusBarOrientationSelector]) {
        [self.statusBarOrientationHandler didChangeStatusBarOrientation:oldStatusBarOrientation];
    }
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame
{
    SEL willChangeStatusBarFrameSelector = @selector(willChangeStatusBarFrame:);
    
    if ([self.statusBarOrientationHandler respondsToSelector:willChangeStatusBarFrameSelector]) {
        [self.statusBarOrientationHandler willChangeStatusBarFrame:newStatusBarFrame];
    }
}

- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame
{
    SEL didChangeStatusBarFrameSelector = @selector(didChangeStatusBarFrame:);
    
    if ([self.statusBarOrientationHandler respondsToSelector:didChangeStatusBarFrameSelector]) {
        [self.statusBarOrientationHandler didChangeStatusBarFrame:oldStatusBarFrame];
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

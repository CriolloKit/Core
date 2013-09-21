//
//  CRAppDelegate.m
//  Core
//
//  Created by TheSooth on 9/19/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRAppDelegate.h"
#import "CRLaunchConfigurator.h"
#import "CRException.h"

#import <CRDIContainer.h>
#import <CRDIInjector.h>

@interface CRAppDelegate () <CRApplicationDelegate>

@property (nonatomic, strong) CRDIContainer *defaultContainer;
@property (nonatomic, strong) CRDIInjector *injector;

@end

@implementation CRAppDelegate

@synthesize ioc_appearanceConfigurator;
@synthesize ioc_pushNotificationsConfigurator;
@synthesize ioc_pushNotificationReceiver;
@synthesize ioc_localNotificationReceiver;
@synthesize ioc_appLifeCycleConfigurator;
@synthesize ioc_urlHandler;
@synthesize ioc_restorationConfigurator;
@synthesize ioc_appMemoryWarrningConfigurator;
@synthesize ioc_windowOrientationConfigurator;
@synthesize ioc_statusBarOrientationHandler;
@synthesize ioc_launcher;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self setupIOC];
    [self setupAppearance];
    [self setupAPNS];
    
    if (!ioc_launcher) {
        @throw [CRException exceptionWithReason:@"launcher not configured"];
    }
    
    [ioc_launcher launchWithWindow:self.window];
    
    return YES;
}

- (void)setupIOC
{
    self.defaultContainer = [CRDIContainer new];
    
    [CRDIContainer setDefaultContainer:self.defaultContainer];
    
    id <CRTargetConfiguration> targetConfiguration = [CRLaunchConfigurator getTargetConfiguration];
    
    [targetConfiguration setContainer:self.defaultContainer];
    
    [targetConfiguration setup];
    
    self.injector = [[CRDIInjector alloc] initWithContainer:self.defaultContainer];
    
    [CRDIInjector setDefaultInjector:self.injector];
    
    [self.injector injectTo:self];
}

- (void)setupAppearance
{
    [self.ioc_appearanceConfigurator setup];
}

#pragma mark -
#pragma mark - Push Notifications Configuration

- (void)setupAPNS
{
    if (self.ioc_pushNotificationsConfigurator) {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:self.ioc_pushNotificationsConfigurator.notificationTypes];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    SEL didRegisterSelector = @selector(didRegisterForRemoteNotificationsWithDeviceToken:);
    
    [self configurator:self.ioc_pushNotificationsConfigurator performSelector:didRegisterSelector withObject:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    SEL didFailRegisterSelector = @selector(didFailToRegisterForRemoteNotificationsWithError:);
    
    [self configurator:self.ioc_pushNotificationsConfigurator performSelector:didFailRegisterSelector withObject:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    SEL didReceiveRemoteNotificationSelector = @selector(didReceiveRemoteNotification:);
    
    [self configurator:self.ioc_pushNotificationReceiver performSelector:didReceiveRemoteNotificationSelector withObject:userInfo];
}

#pragma mark -
#pragma mark - Local Notifications Configuration

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    SEL didReceiveLocalNotificationSelector = @selector(didReceiveLocalNotification:);
    
    [self configurator:self.ioc_localNotificationReceiver performSelector:didReceiveLocalNotificationSelector withObject:notification];
}

#pragma mark -
#pragma mark - Application Lifetime Configuration

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self configurator:self.ioc_appLifeCycleConfigurator performSelector:_cmd withObject:application];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [self configurator:self.ioc_appLifeCycleConfigurator performSelector:_cmd withObject:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self configurator:self.ioc_appLifeCycleConfigurator performSelector:_cmd withObject:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self configurator:self.ioc_appLifeCycleConfigurator performSelector:_cmd withObject:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self configurator:self.ioc_appLifeCycleConfigurator performSelector:_cmd withObject:application];
}

#pragma mark -
#pragma mark - Application URL Handling

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self.ioc_urlHandler handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    SEL openURLSelector = @selector(openURL:sourceApplication:annotation:);
    
    if ([self.ioc_urlHandler respondsToSelector:openURLSelector]) {
        return [self.ioc_urlHandler openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
    
    return NO;
}

#pragma mark -
#pragma mark - Application Restoration Configuration

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents
                            coder:(NSCoder *)coder
{
    SEL viewControllerWithRestorationIdentifierPathSelector = @selector(viewControllerWithIdentifierPath:coder:);
    
    if ([self.ioc_restorationConfigurator respondsToSelector:viewControllerWithRestorationIdentifierPathSelector]) {
      return [self.ioc_restorationConfigurator viewControllerWithIdentifierPath:identifierComponents coder:coder];
    }
    
    return nil;
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
    SEL shouldSaveApplicationStateSelector = @selector(shouldSaveApplicationState:);
    
    if ([self.ioc_restorationConfigurator respondsToSelector:shouldSaveApplicationStateSelector]) {
        return [self.ioc_restorationConfigurator shouldSaveApplicationState:coder];
    }
    
    return NO;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
    SEL shouldRestoreApplicationStateSelector = @selector(shouldRestoreApplicationState:);
    
    if ([self.ioc_restorationConfigurator respondsToSelector:shouldRestoreApplicationStateSelector]) {
        [self.ioc_restorationConfigurator shouldRestoreApplicationState:coder];
    }
    
    return NO;
}

- (void)application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder
{
    SEL willEndoceRestorableStateSelector = @selector(willEncodeRestorableStateWithCoder:);
    
    [self configurator:self.ioc_restorationConfigurator performSelector:willEndoceRestorableStateSelector withObject:coder];
}

- (void)application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder
{
    SEL didDecodeRestorableStateSelector = @selector(didDecodeRestorableStateWithCoder:);
    
    [self configurator:self.ioc_restorationConfigurator performSelector:didDecodeRestorableStateSelector withObject:coder];
}

#pragma mark -
#pragma mark - Application Memory Warrning Configuratror

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [self configurator:self.ioc_appMemoryWarrningConfigurator performSelector:_cmd];
}

#pragma mark -
#pragma mark - Application Window orientation Configurator

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if ([self.ioc_windowOrientationConfigurator respondsToSelector:@selector(supportedInterfaceOrientationsForWindow:)]) {
        return [self.ioc_windowOrientationConfigurator supportedInterfaceOrientationsForWindow:window];
    }
    
    return 0;
}

#pragma mark -
#pragma mark - StatusBar Orientation Handler

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration
{
    SEL willChangeStatusBarOrientationSelector = @selector(willChangeStatusBarOrientation:duration:);
    
    if ([self.ioc_statusBarOrientationHandler respondsToSelector:willChangeStatusBarOrientationSelector]) {
        [self.ioc_statusBarOrientationHandler willChangeStatusBarOrientation:newStatusBarOrientation duration:duration];
    }
}

- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation
{
    SEL didChangeStatusBarOrientationSelector = @selector(didChangeStatusBarOrientation:);
    
    if ([self.ioc_statusBarOrientationHandler respondsToSelector:didChangeStatusBarOrientationSelector]) {
        [self.ioc_statusBarOrientationHandler didChangeStatusBarOrientation:oldStatusBarOrientation];
    }
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame
{
    SEL willChangeStatusBarFrameSelector = @selector(willChangeStatusBarFrame:);
    
    if ([self.ioc_statusBarOrientationHandler respondsToSelector:willChangeStatusBarFrameSelector]) {
        [self.ioc_statusBarOrientationHandler willChangeStatusBarFrame:newStatusBarFrame];
    }
}

- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame
{
    SEL didChangeStatusBarFrameSelector = @selector(didChangeStatusBarFrame:);
    
    if ([self.ioc_statusBarOrientationHandler respondsToSelector:didChangeStatusBarFrameSelector]) {
        [self.ioc_statusBarOrientationHandler didChangeStatusBarFrame:oldStatusBarFrame];
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

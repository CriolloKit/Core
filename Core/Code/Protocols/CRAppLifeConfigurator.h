//
//  CRAppLifeConfigurator.h
//  Core
//
//  Created by TheSooth on 9/19/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CRAppLifeConfigurator <NSObject>

@optional

- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;


@end

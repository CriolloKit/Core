//
//  CRAppMemoryWarrningConfigurator.h
//  Core
//
//  Created by TheSooth on 9/19/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CRAppMemoryWarrningConfigurator <NSObject>

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application;

@end

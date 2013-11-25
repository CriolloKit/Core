//
//  CRAppWindowOrientationConfigurator.h
//  Core
//
//  Created by TheSooth on 9/19/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CRAppWindowOrientationConfigurator <NSObject>

- (NSUInteger)supportedInterfaceOrientationsForWindow:(UIWindow *)window;

@end

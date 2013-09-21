//
//  CRLauncher.h
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CRLauncher <NSObject>

- (void)launchWithWindow:(UIWindow *)aWindow;

@end

//
//  CRStatusBarOrientationHandler.h
//  Core
//
//  Created by TheSooth on 9/19/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CRStatusBarOrientationHandler <NSObject>

@optional

- (void)willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration;
- (void)didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation;

- (void)willChangeStatusBarFrame:(CGRect)newStatusBarFrame;
- (void)didChangeStatusBarFrame:(CGRect)oldStatusBarFrame;

@end

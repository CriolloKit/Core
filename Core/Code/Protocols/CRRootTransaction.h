//
//  CRRootTransaction.h
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CRTransaction.h"

@protocol CRRootTransaction <CRTransaction>

@property (nonatomic, strong) UIWindow *window;

@end

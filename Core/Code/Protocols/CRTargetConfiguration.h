//
//  CRTargetConfiguration.h
//  Core
//
//  Created by TheSooth on 9/20/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CRDIContainer;

@protocol CRTargetConfiguration <NSObject>

- (void)setup;

@optional

@property (nonatomic, strong) CRDIContainer *container;

@end

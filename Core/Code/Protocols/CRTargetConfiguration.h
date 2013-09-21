//
//  CRTargetConfiguration.h
//  Core
//
//  Created by TheSooth on 9/20/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CRDIContainer;
@protocol CRTransactionDispatcher;

@protocol CRTargetConfiguration <NSObject>

- (void)setup;

- (id <CRTransactionDispatcher>)transactionDispatcher;

@optional

@property (nonatomic, strong) CRDIContainer *container;

@end

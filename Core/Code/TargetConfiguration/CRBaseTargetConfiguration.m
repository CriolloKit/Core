//
//  CRBaseTargetConfiguration.m
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRBaseTargetConfiguration.h"
#import "CRHandlersTransactionDispatcher.h"

@implementation CRBaseTargetConfiguration

- (id)init
{
    self = [super init];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (void)setupDefaults
{
    [CRBaseTransactionDispatcher setSharedDispatcher:self.transactionDispatcher];
}

- (void)setup
{
    
}

- (id <CRTransactionDispatcher>)transactionDispatcher
{
    return [CRHandlersTransactionDispatcher new];
}

@end

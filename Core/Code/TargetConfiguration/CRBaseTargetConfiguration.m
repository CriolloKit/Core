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

- (void)setup
{
    [CRBaseTransactionDispatcher setSharedDispatcher:self.transactionDispatcher];
}

- (id <CRTransactionDispatcher>)transactionDispatcher
{
    return [CRHandlersTransactionDispatcher new];
}

@end

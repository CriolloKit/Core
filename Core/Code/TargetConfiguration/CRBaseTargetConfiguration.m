//
//  CRBaseTargetConfiguration.m
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRBaseTargetConfiguration.h"
#import "CRTransactionDispatcher.h"
#import "CRException.h"

@implementation CRBaseTargetConfiguration

- (id)init
{
    self = [super init];
    if (self) {
        [CRTransactionDispatcher setSharedDispatcher:self.transactionDispatcher];
    }
    return self;
}

- (void)setup
{
    @throw [CRException exceptionWithReason:@"verride method"];
}

- (CRTransactionDispatcher *)transactionDispatcher
{
    return [CRTransactionDispatcher new];
}

@end

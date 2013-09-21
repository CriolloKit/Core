//
//  CRBaseTransaction.m
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRBaseTransaction.h"
#import "CRBaseTransactionDispatcher.h"

@interface CRBaseTransaction ()

@property (nonatomic, strong) CRBaseTransactionDispatcher *ioc_transactionDispatcher;

@end

@implementation CRBaseTransaction

- (void)call
{
    [self.ioc_transactionDispatcher dispatchTransaction:self];
}

- (void)callWithObject:(id)aObject
{
    [self.ioc_transactionDispatcher dispatchTransaction:self withObject:aObject];
}

@end

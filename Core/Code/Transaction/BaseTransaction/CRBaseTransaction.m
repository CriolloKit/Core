//
//  CRBaseTransaction.m
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRBaseTransaction.h"
#import "CRBaseTransactionDispatcher.h"
#import "CRException.h"

@interface CRBaseTransaction ()

@end

@implementation CRBaseTransaction

- (void)call
{
    [[CRBaseTransactionDispatcher sharedDispatcher] dispatchTransaction:self];
}

- (void)callWithObject:(id)aObject
{
    [[CRBaseTransactionDispatcher sharedDispatcher] dispatchTransaction:self withObject:aObject];
}

- (void)perform
{
    @throw [CRException exceptionWithReason:@"override method"];
}

- (void)performWithObject:(id)aObject
{
    @throw [CRException exceptionWithReason:@"override method"];
}


@end

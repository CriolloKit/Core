//
//  CRTransactionDispatcher.m
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRBaseTransactionDispatcher.h"
#import "CRTransactionHandler.h"

@implementation CRBaseTransactionDispatcher

- (void)dispatchTransaction:(CRBaseTransaction *)aTransaction
{
    if ([self canPerfomrTransaction:aTransaction withObject:Nil]) {
        [aTransaction perform];
    }
}

- (void)dispatchTransaction:(CRBaseTransaction *)aTransaction withObject:(id)aObject
{
    if ([self canPerfomrTransaction:aTransaction withObject:aObject]) {
        [aTransaction performWithObject:aObject];
    }
}

- (BOOL)canPerfomrTransaction:(id)aTransaction withObject:(id)aObject
{
    return YES;
}

@end

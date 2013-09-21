//
//  CRTransactionDispatcher.m
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRBaseTransactionDispatcher.h"
#import "CRTransactionHandler.h"

static id <CRTransactionDispatcher> sharedDispatcher = nil;

@implementation CRBaseTransactionDispatcher

+ (id <CRTransactionDispatcher>)sharedDispatcher
{
    return sharedDispatcher;
}

+ (void)setSharedDispatcher:(id<CRTransactionDispatcher>)aSharedDispatcher
{
    sharedDispatcher = aSharedDispatcher;
}

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

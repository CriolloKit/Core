//
//  CRTransactionDispatcher.m
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRTransactionDispatcher.h"
#import "CRTransactionHandler.h"

static CRTransactionDispatcher *sharedDispatcher = nil;

@interface CRTransactionDispatcher ()

@property (nonatomic, strong) NSMutableArray *transactionHandlers;

@end

@implementation CRTransactionDispatcher

+ (CRTransactionDispatcher *)sharedDispatcher
{
    return sharedDispatcher;
}

+ (void)setSharedDispatcher:(CRTransactionDispatcher *)aDispatcher
{
    sharedDispatcher = aDispatcher;
}

- (id)initWithTransactionHandlers:(NSArray *)aTransactionHandlers
{
    NSParameterAssert(aTransactionHandlers);
    
    self = [self init];
    
    if (self) {
        self.transactionHandlers = aTransactionHandlers.mutableCopy;
    }
    
    return self;
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
    for (id <CRTransactionHandler> handler in self.transactionHandlers) {
        if(![handler handleTransaction:aTransaction withObject:aObject]) {
            return NO;
        }
    }
    return YES;
}

- (void)addDispatchHandler:(id<CRTransactionHandler>)aDispatcher
{
    NSParameterAssert(aDispatcher);
    
    [self.transactionHandlers addObject:aDispatcher];
}

@end

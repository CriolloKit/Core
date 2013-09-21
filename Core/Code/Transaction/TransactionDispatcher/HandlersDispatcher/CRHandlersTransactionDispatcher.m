//
//  CRHandlersTransactionDispatcher.m
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRHandlersTransactionDispatcher.h"
#import "CRTransactionHandler.h"
#import "CRTargetConfiguration.h"
#import "CRTransactionConfigurator.h"
#import <CRDIContainer.h>

@interface CRHandlersTransactionDispatcher ()

@property (nonatomic, strong) NSArray *transactionHandlers;

@end

@implementation CRHandlersTransactionDispatcher

- (id)init
{
    CRDIContainer *defultContainer = [CRDIContainer defaultContainer];
    if(!defultContainer) {
        @throw [CRDIException exceptionWithReason:@"You must setup default container"];
    }
    
    id <CRTargetConfiguration, CRTransactionConfigurator> targetConfiguration = [[defultContainer builderForProtocol:@protocol(CRTargetConfiguration)] build];
    
    return [self initWithTransactionHandlers:targetConfiguration.transactionHandlers];
}

- (id)initWithTransactionHandlers:(NSArray *)aTransactionHandlers
{
    NSParameterAssert(aTransactionHandlers);
    
    self = [super init];
    
    if (self) {
        self.transactionHandlers = aTransactionHandlers;
    }
    
    return self;
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

@end

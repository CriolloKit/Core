//
//  CRTransactionSpec.m
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Kiwi.h>
#import "CRHandlersTransactionDispatcher.h"
#import "CRTransaction.h"
#import "CRTransactionLogger.h"
#import "CRHandlersTransactionDispatcher.h"

SPEC_BEGIN(CRTransactionSpec)

describe(@"CRTransaction specs", ^{
    it(@"Should perform transaction", ^{
        CRTransactionDispatcher *dispatcher = [CRTransactionDispatcher new];
        CRBaseTransaction *mockTransaction = [KWMock mockForClass:[CRBaseTransaction class]];
        
        [mockTransaction stub:@selector(perform)];
        
        [[mockTransaction should] receive:@selector(perform)];
        
        [dispatcher dispatchTransaction:mockTransaction];
    });
    
    it(@"Should perform transction with logger handler", ^{
        CRTransactionLogger *transactionLogger = [CRTransactionLogger new];
        NSArray *handlers = @[transactionLogger];
        CRHandlersTransactionDispatcher *handlersTransactionDispatcher = [[CRHandlersTransactionDispatcher alloc] initWithTransactionHandlers:handlers];
    
        CRBaseTransaction *mockTransction = [KWMock mockForClass:[CRBaseTransaction class]];
        
        [mockTransction stub:@selector(perform)];
        
        [[mockTransction should] receive:@selector(perform)];
        [[transactionLogger should] receive:@selector(handleTransaction:withObject:) andReturn:@(YES)];
        
        [handlersTransactionDispatcher dispatchTransaction:mockTransction];
    });
    
    it(@"Should return same dispatcher", ^{
        CRTransactionDispatcher *baseDispatcher = [CRTransactionDispatcher new];
        
        [CRTransactionDispatcher setSharedDispatcher:baseDispatcher];
        
        CRHandlersTransactionDispatcher *handlersDispatcher = [CRHandlersTransactionDispatcher sharedDispatcher];
        
        [[baseDispatcher should] equal:handlersDispatcher];
    });
});

SPEC_END

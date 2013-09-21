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

SPEC_BEGIN(CRTransactionSpec)

describe(@"CRTransaction specs", ^{
    it(@"Should perform transaction", ^{
        CRBaseTransactionDispatcher *dispatcher = [CRBaseTransactionDispatcher new];
        NSObject <CRTransaction> *mockTransaction = [KWMock mockForProtocol:@protocol(CRTransaction)];
        
        [mockTransaction stub:@selector(perform)];
        
        [[mockTransaction should] receive:@selector(perform)];
        
        [dispatcher dispatchTransaction:mockTransaction];
    });
    
    it(@"Should perform transction with logger handler", ^{
        CRTransactionLogger *transactionLogger = [CRTransactionLogger new];
        NSArray *handlers = @[transactionLogger];
        CRHandlersTransactionDispatcher *handlersTransactionDispatcher = [[CRHandlersTransactionDispatcher alloc] initWithTransactionHandlers:handlers];
    
        NSObject <CRTransaction> *mockTransction = [KWMock mockForProtocol:@protocol(CRTransaction)];
        
        [mockTransction stub:@selector(perform)];
        
        [[mockTransction should] receive:@selector(perform)];
        [[transactionLogger should] receive:@selector(handleTransaction:withObject:) andReturn:@(YES)];
        
        [handlersTransactionDispatcher dispatchTransaction:mockTransction];
    });
});

SPEC_END

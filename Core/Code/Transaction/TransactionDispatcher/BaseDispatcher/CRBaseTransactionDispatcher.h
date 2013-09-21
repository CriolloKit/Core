//
//  CRTransactionDispatcher.h
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CRTransaction.h"
#import "CRParametrizedTransaction.h"
#import "CRTransactionDispatcher.h"

@interface CRBaseTransactionDispatcher : NSObject <CRTransactionDispatcher>

- (void)dispatchTransaction:(id <CRTransaction>)aTransaction;

- (void)dispatchTransaction:(id<CRParametrizedTransaction>)aTransaction withObject:(id)aObject;

@end

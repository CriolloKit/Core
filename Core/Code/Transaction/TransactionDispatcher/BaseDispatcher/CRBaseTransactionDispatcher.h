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
#import "CRBaseTransaction.h"

@interface CRBaseTransactionDispatcher : NSObject <CRTransactionDispatcher>

- (void)dispatchTransaction:(CRBaseTransaction *)aTransaction;

- (void)dispatchTransaction:(CRBaseTransaction *)aTransaction withObject:(id)aObject;

@end

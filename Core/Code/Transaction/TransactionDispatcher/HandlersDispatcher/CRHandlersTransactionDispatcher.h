//
//  CRHandlersTransactionDispatcher.h
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRBaseTransactionDispatcher.h"

@interface CRHandlersTransactionDispatcher : CRBaseTransactionDispatcher

- (id)initWithTransactionHandlers:(NSArray *)aTransactionHandlers;

@end

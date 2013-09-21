//
//  CRTransactionHandler.h
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRTransaction.h"

@protocol CRTransactionHandler <NSObject>

- (BOOL)handleTransaction:(id <CRTransaction>)aTransaction withObject:(id)aObject;

@end

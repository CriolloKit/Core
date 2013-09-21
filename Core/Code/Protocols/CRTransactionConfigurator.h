//
//  CRTransactionConfigurator.h
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRRootTransaction.h"

@protocol CRTransactionConfigurator <NSObject>

@property (nonatomic, strong, readonly) NSArray *transactionHandlers;
@property (nonatomic, strong, readonly) id <CRRootTransaction> rootTransaction;

@end

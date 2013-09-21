//
//  CRTransactionLogger.m
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRTransactionLogger.h"

@implementation CRTransactionLogger

- (BOOL)handleTransaction:(id)aTransaction withObject:(id)aObject
{
    NSLog(@"Peforming transaction %@ withObject %@", aTransaction, aObject);
    
    return YES;
}

@end

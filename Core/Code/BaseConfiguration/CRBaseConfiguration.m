//
//  CRBaseConfiguration.m
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRBaseConfiguration.h"
#import "CRTransactionLogger.h"
#import "CRException.h"

@implementation CRBaseConfiguration

- (void)setup
{
    @throw [CRException exceptionWithReason:@"You must override this method"];
}

- (NSArray *)transactionHandlers
{
    return @[[CRTransactionLogger new]];
}

@end

//
//  CRBaseTransaction.h
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRTransaction.h"
#import "CRParametrizedTransaction.h"

@interface CRBaseTransaction : NSObject <CRTransaction, CRParametrizedTransaction>

- (void)perform;
- (void)performWithObject:(id)aObject;

@end

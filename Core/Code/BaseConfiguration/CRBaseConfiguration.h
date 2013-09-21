//
//  CRBaseConfiguration.h
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRTransactionConfigurator.h"
#import "CRRootTransaction.h"
#import "CRTargetConfiguration.h"

@interface CRBaseConfiguration : NSObject <CRTransactionConfigurator, CRTargetConfiguration>

@end

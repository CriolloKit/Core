//
//  CRLaunchConfigurator.h
//  Core
//
//  Created by TheSooth on 9/20/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRTargetConfiguration.h"

@interface CRLaunchConfigurator : NSObject

+ (id <CRTargetConfiguration>)getTargetConfiguration;

@end

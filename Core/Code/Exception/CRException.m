//
//  CRException.m
//  Core
//
//  Created by TheSooth on 9/20/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRException.h"

@implementation CRException

+ (CRException *)exceptionWithReason:(NSString *)aReson
{
    return (CRException *)[CRException exceptionWithName:@"CRException" reason:aReson userInfo:nil];
}

@end

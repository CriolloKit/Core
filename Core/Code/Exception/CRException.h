//
//  CRException.h
//  Core
//
//  Created by TheSooth on 9/20/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRException : NSException

+ (CRException *)exceptionWithReason:(NSString *)aReson;

@end

//
//  CRTransaction.h
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CRTransaction <NSObject>

@optional
- (void)perform;

@end

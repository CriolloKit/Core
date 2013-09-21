//
//  CRTransactionDispatcher.h
//  Core
//
//  Created by TheSooth on 9/21/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CRTransactionDispatcher <NSObject>

- (BOOL)canPerfomrTransaction:(id)aTransaction withObject:(id)aObject;

@end

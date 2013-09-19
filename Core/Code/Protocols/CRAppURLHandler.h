//
//  CRAppURLHandler.h
//  Core
//
//  Created by TheSooth on 9/19/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CRAppURLHandler <NSObject>

- (BOOL)handleOpenURL:(NSURL *)url;

@optional

- (BOOL)openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation

@end

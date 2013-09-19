//
//  CRLocalNotificationReceiver.h
//  Core
//
//  Created by TheSooth on 9/19/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CRLocalNotificationReceiver <NSObject>

- (void)didReceiveLocalNotification:(UILocalNotification *)aNotification;

@end

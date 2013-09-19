//
//  CRAppStateHandler.h
//  Core
//
//  Created by TheSooth on 9/19/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CRAppRestorationStateConfigurator <NSObject>

@optional

- (UIViewController *)viewControllerWithIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder;

- (BOOL)shouldSaveApplicationState:(NSCoder *)coder;

- (BOOL)shouldRestoreApplicationState:(NSCoder *)coder;

- (void)willEncodeRestorableStateWithCoder:(NSCoder *)coder;
- (void)didDecodeRestorableStateWithCoder:(NSCoder *)coder;

@end

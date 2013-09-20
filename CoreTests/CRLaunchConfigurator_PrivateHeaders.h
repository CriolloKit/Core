//
//  CRLaunchConfigurator_PrivateHeaders.h
//  Core
//
//  Created by TheSooth on 9/20/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRLaunchConfigurator.h"
#import "CRTargetConfiguration.h"

static  NSString *const kCriolloKitConfigDictionaryKey = @"CriolloKit";

@interface CRLaunchConfigurator ()

+ (id <CRTargetConfiguration>)buildConfiguration;

+ (Class)configurationClassFromDictionary:(NSDictionary *)aDictionary
                     currentConfiguration:(NSString *)aConfiguration;

+ (NSDictionary *)configurationDictionaryFromCriolloConfigKey:(NSString *)aConfigKey;

+ (NSDictionary *)rootDictionary;

+ (NSString *)currentConfiguration;

@end

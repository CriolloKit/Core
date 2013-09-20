//
//  CRLaunchConfigurator.m
//  Core
//
//  Created by TheSooth on 9/20/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "CRLaunchConfigurator.h"
#import "CRTargetConfiguration.h"
#import "CRException.h"

#define STR_VALUE(arg)      #arg
#define GET_CONFIGURATION_NAME(name) NSString *kConfigurationName = @STR_VALUE(name)

static  NSString *const kCriolloKitConfigDictionaryKey = @"CriolloKit";

@implementation CRLaunchConfigurator

+ (void)setup
{
    id <CRTargetConfiguration> targetConfiguration = [self buildConfiguration];
    
    [targetConfiguration setup];
}

+ (id <CRTargetConfiguration>)buildConfiguration
{
    NSDictionary *configurationDictionary = [self configurationDictionaryFromCriolloConfigKey:kCriolloKitConfigDictionaryKey];
    NSString *currentConfiguration = [self currentConfiguration];
    
    Class configurationClass = [self configurationClassFromDictionary:configurationDictionary currentConfiguration:currentConfiguration];
    
    id <CRTargetConfiguration> configuration = [[configurationClass alloc] init];
    
    if (!configuration) {
        NSString *exceptionReason = [NSString stringWithFormat:@"Cannot create instance of %@", NSStringFromClass(configurationClass)];
        @throw [CRException exceptionWithReason:exceptionReason];
    }
    
    if (![configuration conformsToProtocol:@protocol(CRTargetConfiguration)]) {
        NSString *exceptionReason = [NSString stringWithFormat:@"Class %@ not conforms to %@ protocol", NSStringFromClass(configurationClass),
                                     NSStringFromProtocol(@protocol(CRTargetConfiguration))];
        @throw [CRException exceptionWithReason:exceptionReason];
    }
    
    return configuration;
}

+ (Class)configurationClassFromDictionary:(NSDictionary *)aDictionary
                     currentConfiguration:(NSString *)aConfiguration
{
    NSString *classString = aDictionary[aConfiguration];
    
    if (!classString) {
        @throw [CRException exceptionWithReason:@"Not class for current configuration"];
    }
    
    return NSClassFromString(classString);
}

+ (NSDictionary *)configurationDictionaryFromCriolloConfigKey:(NSString *)aConfigKey
{
    NSDictionary *rootDictionary = [self rootDictionary];
    
    NSDictionary *configurationDictionary = rootDictionary[aConfigKey];
    
    if (!configurationDictionary) {
        @throw [CRException exceptionWithReason:@"Config key not found"];
    }
    
    return configurationDictionary;
}

+ (NSDictionary *)rootDictionary
{
    return [[NSBundle mainBundle] infoDictionary];
}

+ (NSString *)currentConfiguration
{
    GET_CONFIGURATION_NAME(CONFIGURATION);
    
    return kConfigurationName;
}

@end

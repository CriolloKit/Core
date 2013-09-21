#import <Kiwi/Kiwi.h>

#import "CRLaunchConfigurator.h"
#import "CRSampleTargetConfguration.h"
#import "CRLaunchConfigurator_PrivateHeaders.h"


SPEC_BEGIN(CRLaunchConfiguratorSpec)

describe(@"CRLaunchConfigurator Spec", ^{
   it(@"Should create instance of CRSampleTargetConfguration and run setup method", ^{
       
       NSString *sampleTargetConfigurationClassString = NSStringFromClass([CRSampleTargetConfguration class]);
       
       NSDictionary *configDictionary = @{@"Debug" : sampleTargetConfigurationClassString,
                                          @"Release" : sampleTargetConfigurationClassString};
       
       NSDictionary *rootDictionary = @{kCriolloKitConfigDictionaryKey: configDictionary};
       
       [CRLaunchConfigurator stub:@selector(rootDictionary) andReturn:rootDictionary];
       
       NSObject <CRTargetConfiguration> *targetConfiguration = [CRLaunchConfigurator getTargetConfiguration];
       
       [[targetConfiguration shouldNot] beNil];
   });
    
    it(@"Should raise due to non exists key in info dictionary", ^{
        [[theBlock(^{
            [CRLaunchConfigurator configurationDictionaryFromCriolloConfigKey:kCriolloKitConfigDictionaryKey];
        }) should] raise];
    });
    
    it(@"Should raise due to non exists class in config dictionary", ^{
        [[theBlock(^{
            [CRLaunchConfigurator configurationClassFromDictionary:@{} currentConfiguration:@""];
        }) should] raise];
    });
    
    it(@"Should raise due to non-conforming CRTargetConfiguration protocol on building class", ^{
        NSString *sampleTargetConfigurationClassString = NSStringFromClass([NSString class]);
        
        NSDictionary *configDictionary = @{@"Debug" : sampleTargetConfigurationClassString,
                                           @"Release" : sampleTargetConfigurationClassString};
        
        NSDictionary *rootDictionary = @{kCriolloKitConfigDictionaryKey: configDictionary};
        
        [CRLaunchConfigurator stub:@selector(rootDictionary) andReturn:rootDictionary];
        [[theBlock(^{
            [CRLaunchConfigurator getTargetConfiguration];
        }) should] raise];
    });
});

SPEC_END
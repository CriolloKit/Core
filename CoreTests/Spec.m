#import <Kiwi/Kiwi.h>
#import "Core.h"


SPEC_BEGIN(CoreSpec)

describe(@"Feature", ^{
   it(@"should work", ^{
       [[[Core new] shouldNot] beNil];
   });
});

SPEC_END
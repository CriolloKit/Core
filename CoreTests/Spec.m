#import <Kiwi/Kiwi.h>


SPEC_BEGIN(CoreSpec)

describe(@"Feature", ^{
   it(@"should work", ^{
       [[[NSObject new] shouldNot] beNil];
   });
});

SPEC_END
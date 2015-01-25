#import "Mave.h"
#import "MaveSDK.h"

@implementation Mave

- (void)init:(CDVInvokedUrlCommand*)command {
    NSMutableDictionary *retParams = [[NSMutableDictionary alloc] init];
    NSArray *args = command.arguments;
    if ([args count]) {
        NSString* applicationId = [args objectAtIndex:0];
        [MaveSDK setupSharedInstanceWithApplicationID:applicationId];
    }
}

@end

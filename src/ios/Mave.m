#import "Mave.h"
#import "./mave-ios-sdk/MaveSDK/MaveSDK.h"

- (void)init:(CDVInvokedUrlCommand*)command {
    NSMutableDictionary *retParams = [[NSMutableDictionary alloc] init];
    NSArray *args = command.arguments;
    if ([args count]) {
        NSString* applicationId = [args objectAtIndex:0];
        [MaveSDK setupSharedInstanceWithApplicationID:applicationId];
    }
}

#import <Cordova/CDV.h>

@interface Mave : CDVPlugin {
  // Member variables go here.
    
}

@property(strong) NSString* callbackID;
- (void)init:(CDVInvokedUrlCommand*)command;
@end

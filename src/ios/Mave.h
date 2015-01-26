#import <Cordova/CDV.h>

@interface Mave : CDVPlugin {
  // Member variables go here.
}

@property(strong) NSString* callbackID;
- (void)setupSharedInstanceWithApplicationID:(CDVInvokedUrlCommand*)command;
- (void)identifyUser:(CDVInvokedUrlCommand*)command;
- (void)identifyAnonymousUser:(CDVInvokedUrlCommand*)command;
- (void)presentInvitePageModallyWithBlock:(CDVInvokedUrlCommand*)command;
- (void)trackSignup:(CDVInvokedUrlCommand*)command;
@end

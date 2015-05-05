#import <Cordova/CDV.h>

@interface Mave : CDVPlugin {
  // Member variables go here.
}

@property(strong) NSString* callbackID;
- (void)setupSharedInstanceWithApplicationID:(CDVInvokedUrlCommand*)command;
- (void)getReferringData:(CDVInvokedUrlCommand*)command;
- (void)identifyUser:(CDVInvokedUrlCommand*)command;
- (void)identifyAnonymousUser:(CDVInvokedUrlCommand*)command;
- (void)presentInvitePageModallyWithBlock:(CDVInvokedUrlCommand*)command;
- (void)trackSignup:(CDVInvokedUrlCommand*)command;

- (void)setNavigationBarOptions:(CDVInvokedUrlCommand*)command;
- (void)setInviteExplanationOptions:(CDVInvokedUrlCommand*)command;
- (void)setContactOptions:(CDVInvokedUrlCommand*)command;
- (void)setContactSectionOptions:(CDVInvokedUrlCommand*)command;
- (void)setMessageSectionOptions:(CDVInvokedUrlCommand*)command;
- (void)setSharePageOptions:(CDVInvokedUrlCommand*)command;
@end

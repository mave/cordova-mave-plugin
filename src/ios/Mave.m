#import "Mave.h"
#import "MaveSDK.h"

@implementation Mave

- (void)setupSharedInstanceWithApplicationID:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;
    NSArray *args = command.arguments;
    if ([args count]) {
        NSString* applicationId = [args objectAtIndex:0];
        [MaveSDK setupSharedInstanceWithApplicationID:applicationId];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No Application ID Passed in"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)identifyUser:(CDVInvokedUrlCommand*)command {
    // Args are [userId, firstName, lastName, email, phone]
    CDVPluginResult* pluginResult = nil;
    NSArray *args = command.arguments;
    NSString* userId = [args objectAtIndex:0];
    NSString* firstName = [args objectAtIndex:1];
    NSString* lastName = [args objectAtIndex:2];
    NSString* email = [args objectAtIndex:3];
    NSString* phone = [args objectAtIndex:4];
    MAVEUserData *userData = [[MAVEUserData alloc] initWithUserID:userId
                                                         firstName:firstName
                                                          lastName:lastName
                                                             email:email
                                                             phone:phone];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [[MaveSDK sharedInstance] identifyUser:userData];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)identifyAnonymousUser:(CDVInvokedUrlCommand*)command {
    [[MaveSDK sharedInstance] identifyAnonymousUser];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)presentInvitePageModallyWithBlock:(CDVInvokedUrlCommand*)command {
    MaveSDK *mave = [MaveSDK sharedInstance];
    [mave presentInvitePageModallyWithBlock:^(UIViewController *inviteController) {
        // Code to present Mave's view controller
        [self.viewController presentViewController:inviteController animated:YES completion:nil];
    } dismissBlock:^(UIViewController *controller, NSUInteger numberOfInvitesSent) {
        // Code to transition back to your view controller after Mave's is dismissed
        [controller dismissViewControllerAnimated:YES completion:nil];
        // TODO: Return number of invites
    } inviteContext:@"default"];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)trackSignup:(CDVInvokedUrlCommand*)command {
    [[MaveSDK sharedInstance] trackSignup];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end

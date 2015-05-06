#import "Mave.h"
#import "MaveSDK.h"

@implementation Mave

- (void)setupSharedInstanceWithApplicationID:(CDVInvokedUrlCommand*)command {
    NSArray *args = command.arguments;
    if ([args count]) {
        [self.commandDelegate runInBackground:^{
            NSString* applicationId = [args objectAtIndex:0];
            [MaveSDK setupSharedInstanceWithApplicationID:applicationId];
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    } else {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No Application ID Passed in"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)identifyUser:(CDVInvokedUrlCommand*)command {
    // Args are [userID, firstName, lastName, email, phone]
    [self.commandDelegate runInBackground:^{
        NSArray *args = command.arguments;
        NSString* userID = [args objectAtIndex:0];
        NSString* firstName = [args objectAtIndex:1];
        NSString* lastName = [args objectAtIndex:2];
        NSString* email = [args objectAtIndex:3];
        NSString* phone = [args objectAtIndex:4];
        MAVEUserData *userData = [[MAVEUserData alloc] initWithUserID:userID
                                                             firstName:firstName
                                                              lastName:lastName
                                                                 email:email
                                                                 phone:phone];
        [[MaveSDK sharedInstance] identifyUser:userData];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)identifyAnonymousUser:(CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{
        [[MaveSDK sharedInstance] identifyAnonymousUser];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)presentInvitePageModallyWithBlock:(CDVInvokedUrlCommand*)command {
    MaveSDK *mave = [MaveSDK sharedInstance];
    [mave presentInvitePageModallyWithBlock:^(UIViewController *inviteController) {
        // Code to present Mave's view controller
        [self.viewController presentViewController:inviteController animated:YES completion:nil];
    } dismissBlock:^(UIViewController *controller, NSUInteger numberOfInvitesSent) {
        // Code to transition back to your view controller after Mave's is dismissed
        [controller dismissViewControllerAnimated:YES completion:nil];
        NSMutableDictionary* returnInfo = [NSMutableDictionary dictionaryWithCapacity:1];
        [returnInfo setObject:[NSNumber numberWithInteger:numberOfInvitesSent] forKey:@"numberOfInvitesSent"];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnInfo];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    } inviteContext:@"default"];
}

- (void)trackSignup:(CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{
        [[MaveSDK sharedInstance] trackSignup];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)getReferringData:(CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{
        NSMutableDictionary* returnInfo = [NSMutableDictionary dictionaryWithCapacity:5];
        [[MaveSDK sharedInstance] getReferringData:^(MAVEReferringData *referringData) {
          if (referringData) {
            [returnInfo setObject:referringData.customData forKey:@"customData"];
            [returnInfo setObject:referringData.currentUser.phone forKey:@"currentUserPhone"];
            MAVEUserData *referringUser = referringData.referringUser;
            if (referringUser) {
              [returnInfo setObject:referringUser.userID forKey:@"referringUserID"];
              [returnInfo setObject:referringUser.firstName forKey:@"referringUserFirstName"];
              [returnInfo setObject:referringUser.lastName forKey:@"referringUserLastName"];
              [returnInfo setObject:referringUser.email forKey:@"referringUserEmail"];
              [returnInfo setObject:referringUser.phone forKey:@"referringUserPhone"];
            }
          }
          CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnInfo];
          [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    }];
}

/* Configuration */

- (UIColor*)UIColorFromHexString:(NSString*)hexString {
    unsigned result = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&result];
    return [UIColor colorWithRed:((float)((result & 0xFF0000) >> 16))/255.0 green:((float)((result & 0xFF00) >> 8))/255.0 blue:((float)(result & 0xFF))/255.0 alpha:1.0];
}

- (void)setNavigationBarOptions:(CDVInvokedUrlCommand*)command {
    NSString* navigationBarTitleCopy = [command.arguments objectAtIndex:0];
    NSString* navigationBarTitleTextColor = [command.arguments objectAtIndex:1];
    NSString* navigationBarBackgroundColor = [command.arguments objectAtIndex:2];
    NSString* navigationBarCancelButtonTitle = [command.arguments objectAtIndex:3];
    NSString* navigationBarCancelButtonTintColor = [command.arguments objectAtIndex:4];

    MaveSDK *mave = [MaveSDK sharedInstance];
    if ( ![navigationBarTitleCopy isEqual:[NSNull null]] )
        mave.displayOptions.navigationBarTitleCopy = navigationBarTitleCopy;
    if ( ![navigationBarTitleTextColor isEqual:[NSNull null]] )
        mave.displayOptions.navigationBarTitleTextColor = [self UIColorFromHexString:navigationBarTitleTextColor];
    if ( ![navigationBarBackgroundColor isEqual:[NSNull null]] )
        mave.displayOptions.navigationBarBackgroundColor = [self UIColorFromHexString:navigationBarBackgroundColor];
    if ( ![navigationBarCancelButtonTitle isEqual:[NSNull null]] )
        mave.displayOptions.navigationBarCancelButton.title = navigationBarCancelButtonTitle;
    if ( ![navigationBarCancelButtonTintColor isEqual:[NSNull null]] )
        mave.displayOptions.navigationBarCancelButton.tintColor = [self UIColorFromHexString:navigationBarCancelButtonTintColor];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setInviteExplanationOptions:(CDVInvokedUrlCommand*)command {
    NSString* inviteExplanationTextColor = [command.arguments objectAtIndex:0];
    NSString* inviteExplanationCellBackgroundColor = [command.arguments objectAtIndex:1];
    NSString* inviteExplanationShareButtonsColor = [command.arguments objectAtIndex:2];
    NSString* inviteExplanationShareButtonsBackgroundColor = [command.arguments objectAtIndex:3];

    MaveSDK *mave = [MaveSDK sharedInstance];
    if ( ![inviteExplanationTextColor isEqual:[NSNull null]] )
        mave.displayOptions.inviteExplanationTextColor = [self UIColorFromHexString:inviteExplanationTextColor];
    if ( ![inviteExplanationCellBackgroundColor isEqual:[NSNull null]] )
        mave.displayOptions.inviteExplanationCellBackgroundColor = [self UIColorFromHexString:inviteExplanationCellBackgroundColor];
    if ( ![inviteExplanationShareButtonsColor isEqual:[NSNull null]] )
        mave.displayOptions.inviteExplanationShareButtonsColor = [self UIColorFromHexString:inviteExplanationShareButtonsColor];
    if ( ![inviteExplanationShareButtonsBackgroundColor isEqual:[NSNull null]] )
        mave.displayOptions.inviteExplanationShareButtonsBackgroundColor = [self UIColorFromHexString:inviteExplanationShareButtonsBackgroundColor];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setContactOptions:(CDVInvokedUrlCommand*)command {
    NSString* contactNameTextColor = [command.arguments objectAtIndex:0];
    NSString* contactDetailsTextColor = [command.arguments objectAtIndex:1];
    NSString* contactSeparatorColor = [command.arguments objectAtIndex:2];
    NSString* contactCellBackgroundColor = [command.arguments objectAtIndex:3];
    NSString* contactCheckmarkColor = [command.arguments objectAtIndex:4];

    MaveSDK *mave = [MaveSDK sharedInstance];
    if ( ![contactNameTextColor isEqual:[NSNull null]] )
        mave.displayOptions.contactNameTextColor = [self UIColorFromHexString:contactNameTextColor];
    if ( ![contactDetailsTextColor isEqual:[NSNull null]] )
        mave.displayOptions.contactDetailsTextColor = [self UIColorFromHexString:contactDetailsTextColor];
    if ( ![contactSeparatorColor isEqual:[NSNull null]] )
        mave.displayOptions.contactSeparatorColor = [self UIColorFromHexString:contactSeparatorColor];
    if ( ![contactCellBackgroundColor isEqual:[NSNull null]] )
        mave.displayOptions.contactCellBackgroundColor = [self UIColorFromHexString:contactCellBackgroundColor];
    if ( ![contactCheckmarkColor isEqual:[NSNull null]] )
        mave.displayOptions.contactCheckmarkColor = [self UIColorFromHexString:contactCheckmarkColor];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setContactSectionOptions:(CDVInvokedUrlCommand*)command {
    NSString* contactSectionHeaderTextColor = [command.arguments objectAtIndex:0];
    NSString* contactSectionHeaderBackgroundColor = [command.arguments objectAtIndex:1];
    NSString* contactSectionIndexColor = [command.arguments objectAtIndex:2];
    NSString* contactSectionIndexBackgroundColor = [command.arguments objectAtIndex:3];

    MaveSDK *mave = [MaveSDK sharedInstance];
    if ( ![contactSectionHeaderTextColor isEqual:[NSNull null]] )
        mave.displayOptions.contactSectionHeaderTextColor = [self UIColorFromHexString:contactSectionHeaderTextColor];
    if ( ![contactSectionHeaderBackgroundColor isEqual:[NSNull null]] )
        mave.displayOptions.contactSectionHeaderBackgroundColor = [self UIColorFromHexString:contactSectionHeaderBackgroundColor];
    if ( ![contactSectionIndexColor isEqual:[NSNull null]] )
        mave.displayOptions.contactSectionIndexColor = [self UIColorFromHexString:contactSectionIndexColor];
    if ( ![contactSectionIndexBackgroundColor isEqual:[NSNull null]] )
        mave.displayOptions.contactSectionIndexBackgroundColor = [self UIColorFromHexString:contactSectionIndexBackgroundColor];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setMessageSectionOptions:(CDVInvokedUrlCommand*)command {
    NSString* messageFieldTextColor = [command.arguments objectAtIndex:0];
    NSString* messageFieldBackgroundColor = [command.arguments objectAtIndex:1];
    NSString* sendButtonCopy = [command.arguments objectAtIndex:2];
    NSString* sendButtonTextColor = [command.arguments objectAtIndex:3];
    NSString* bottomViewBorderColor = [command.arguments objectAtIndex:4];
    NSString* bottomViewBackgroundColor = [command.arguments objectAtIndex:5];

    MaveSDK *mave = [MaveSDK sharedInstance];
    if ( ![messageFieldTextColor isEqual:[NSNull null]] )
        mave.displayOptions.messageFieldTextColor = [self UIColorFromHexString:messageFieldTextColor];
    if ( ![messageFieldBackgroundColor isEqual:[NSNull null]] )
        mave.displayOptions.messageFieldBackgroundColor = [self UIColorFromHexString:messageFieldBackgroundColor];
    if ( ![sendButtonCopy isEqual:[NSNull null]] )
        mave.displayOptions.sendButtonCopy = sendButtonCopy;
    if ( ![sendButtonTextColor isEqual:[NSNull null]] )
        mave.displayOptions.sendButtonTextColor = [self UIColorFromHexString:sendButtonTextColor];
    if ( ![bottomViewBorderColor isEqual:[NSNull null]] )
        mave.displayOptions.bottomViewBorderColor = [self UIColorFromHexString:bottomViewBorderColor];
    if ( ![bottomViewBackgroundColor isEqual:[NSNull null]] )
        mave.displayOptions.bottomViewBackgroundColor = [self UIColorFromHexString:bottomViewBackgroundColor];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setSharePageOptions:(CDVInvokedUrlCommand*)command {
    NSString* sharePageBackgroundColor = [command.arguments objectAtIndex:0];
    NSString* sharePageIconColor = [command.arguments objectAtIndex:1];
    NSString* sharePageIconTextColor = [command.arguments objectAtIndex:2];
    NSString* sharePageExplanationTextColor = [command.arguments objectAtIndex:3];

    MaveSDK *mave = [MaveSDK sharedInstance];
    if ( ![sharePageBackgroundColor isEqual:[NSNull null]] )
        mave.displayOptions.sharePageBackgroundColor = [self UIColorFromHexString:sharePageBackgroundColor];
    if ( ![sharePageIconColor isEqual:[NSNull null]] )
        mave.displayOptions.sharePageIconColor = [self UIColorFromHexString:sharePageIconColor];
    if ( ![sharePageIconTextColor isEqual:[NSNull null]] )
        mave.displayOptions.sharePageIconTextColor = [self UIColorFromHexString:sharePageIconTextColor];
    if ( ![sharePageExplanationTextColor isEqual:[NSNull null]] )
        mave.displayOptions.sharePageExplanationTextColor = [self UIColorFromHexString:sharePageExplanationTextColor];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end

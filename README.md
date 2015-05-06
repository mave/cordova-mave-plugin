# cordova-mave-plugin
Cordova/PhoneGap plugin for the Mave iOS SDK

# Installation
This plugin is available through the [Cordova Plugin Registry](http://plugins.cordova.io/#/package/io.mave.plugins.mave).
To Install the plugin, execute the following command in your app's project directory:

```bash
cordova plugin add io.mave.plugins.mave
```

# Using the plugin
Take a look at the [docs](http://mave.io/betadocs/integrate) for details on how the SDK works. Below you'll find the javascript functions that correspond to the SDK methods in the docs.

## Setting up the SDK on launch
When your app is launched, you should initialize the library like this:
```javascript
var applicationId = '<YOUR_APPLICATION_ID>';
mave.setupSharedInstanceWithApplicationID(applicationId);
```

## Identifying your user
There are two ways to identify a user. You can identify a logged in user:
```javascript
var userData = {
  userID: '123', // Only userID and firstName are required
  firstName: 'John',
  lastName: 'Doe',
  email: 'john@example.com',
  phone: '888-555-1234'
};
mave.identifyUser(userData,
                  function () {console.log('identifyUser success!')}, // success callback (optional)
                  function (e) {console.log('identifyUser error: ' + e)}); //error callback (optional)
```
Or you can identify an anonymous user:
```javascript
mave.identifyAnonymousUser(
  function () {console.log('identifyAnonymousUser success!')}, // success callback (optional)
  function (e) {console.log('identifyAnonymousUser error: ' + e)}); //error callback (optional)
```

## Displaying the invite page
Once the user is identified, you can display the invite page modal like this:
```javascript
mave.presentInvitePageModally();
```
You can pass in a callback to `presentInvitePageModally` to get number of invites sent after the modal is dismissed, like this:
```javascript
mave.presentInvitePageModally(function(data) {
  console.log('Successfully sent ' + data.numberOfInvitesSent + ' invites!');
});
```

## Tracking signups
When you get a new signup, first identify the user then call
```javascript
mave.trackSignup(
  successCallback, // optional
  errorCallback // optional
);
```

## Getting the referring data
When you get a new app launch, you can get get the data on the user who sent the referral, and who the current user is. Just pass in a callback that accepts a referringData object. If no referring data is found, an empty object is passed to the callback.
```javascript
mave.getReferringData(function (referringData) {
  console.log('Referring User ID: ' + referringData.referringUserID);
  console.log('Referring User first name: ' + referringData.referringUserFirstName);
  console.log('Referring User last name: ' + referringData.referringUserLastName);
  console.log('Referring User email: ' + referringData.referringUserEmail);
  console.log('Referring User phone: ' + referringData.referringUserPhone);
  console.log('Current User phone: ' + referringData.currentUserPhone);
  var customData = referringData.customData;
});
```

## Configuration
See http://mave.io/betadocs/customize/ for more details on what can be customized.
To customize the invite page through this plugin, all you need to do is call `setDisplayOptions` on an object containing the configuration variables you would like to overwrite. This should be called before the invite page is presented.
All options are optional and do not need to be specified if you want to use the default value. Full example:
```javascript
    var displayOptions = {
      navigationBarTitleCopy: 'Invite Your Friends',
      navigationBarTitleTextColor: '#000000', // If a color is specified, it must be in this hex value form
      navigationBarBackgroundColor: '#DDDDDD',
      navigationBarCancelButtonTitle: 'Cancel',
      navigationBarCancelButtonTintColor: '#999999',

      inviteExplanationTextColor: '#FFFFFF',
      inviteExplanationCellBackgroundColor: '#009999',
      inviteExplanationShareButtonsColor: '#990000',
      inviteExplanationShareButtonsBackgroundColor: '#009999',

      searchBarPlaceholderTextColor: '#DDDDDD',
      searchBarSearchTextColor: '#000000',
      searchBarBackgroundColor: '#FFFFFF',
      searchBarTopBorderColor: '#FFFFFF',

      contactNameTextColor: '#000000',
      contactDetailsTextColor: '#DDDDDD',
      contactSeparatorColor: '#000000',
      contactCellBackgroundColor: '#FFFFFF',
      contactCheckmarkColor: '#990000',
      contactSectionHeaderTextColor: '#000000',
      contactSectionHeaderBackgroundColor: '#FFFFFF',
      contactSectionIndexColor: '#000000',
      contactSectionIndexBackgroundColor: '#FFFFFF',

      contactInlineSendButtonTextColor: '#990000',
      contactInlineSendButtonDisabledTextColor: '#DDDDDD',

      messageFieldTextColor: '#000000',
      messageFieldBackgroundColor: '#FFFFFF',

      sendButtonCopy: 'Send',
      sendButtonTextColor: '#990000',

      bottomViewBorderColor: '#000000',
      bottomViewBackgroundColor: '#FFFFFF',

      sharePageBackgroundColor: '#009999',
      sharePageIconColor: '#990000',
      sharePageIconTextColor: '#990000',
      sharePageExplanationTextColor: '#FFFFFF'
    };

    mave.setDisplayOptions(displayOptions);
```

# Building the plugin locally
The plugin can be built automatically from a local directory where the iOS Mave SDK lives. To build the SDK Locally...

1. Make sure the `mave-ios-sdk` directory is in the same parent directory as this directory (`cordova-mave-plugin`)
2. Check out the correct sha/tag of the iOS SDK, since these local files will be used to build the Cordova plugin
3. In the `cordova-mave-plugin` directory, `cd scripts/update-ios-cocoapod/`
4. Simply running `make` will build the SDK in the root directory of the Cordova plugin.
5. `make clean` will clean out any leftover temp files from the build steps.
6. Check in the newly changes in the root directory, and update the version in `plugin.xml`, if you are bumping the version

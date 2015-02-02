# cordova-mave-plugin
Cordova plugin for the Mave iOS SDK

# Installation
This plugin is not yet available through the Cordova Plugin Registry, so it will need to be unzipped and installed locally.

Unzip the plugin into it's own directory and add the plugin using `cordova plugin add /path/to/plugin/`

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

## Getting the referring user
When you get a new app launch, you can get get the data on the user who sent the referral. Just pass in a callback that accepts a userData object. If no referring user is found, an empty object is passed to the callback.
```javascript
mave.getReferringUser(function (userData) {
  console.log('User ID: ' + userData.userID);
  console.log('User first name: ' + userData.firstName);
  console.log('User last name: ' + userData.lastName);
  console.log('User email: ' + userData.email);
  console.log('User phone: ' + userData.phone);
});
```

## Configuration
See http://mave.io/betadocs/customize/ for more details on what can be customized.
To customize the invite page through this plugin, all you need to do is call `setDisplayOptions` on an object containing the configuration variables you would like to overwrite. This should be called before the invite page is presented.
All options are optional and do not need to be specified if you want to use the default value. Full example:
```javascript
    var displayOptions = {
      navigationBarTitleCopy: 'Invite Your Friends',
      navigationBarTitleTextColor: '#CCCCCC', // If a color is specified, it must be in this hex value form
      navigationBarBackgroundColor: '#WWWWWW',
      navigationBarCancelButtonTitle: 'Cancel',
      navigationBarCancelButtonTintColor: '#999999',
      inviteExplanationTextColor: '#990000',
      inviteExplanationCellBackgroundColor: '#009999',
      contactNameTextColor: '#FFFC13',
      contactDetailsTextColor: '#990000',
      contactSeparatorColor: '#WWWWWW',
      contactCellBackgroundColor: '#CCCCCC',
      contactCheckmarkColor: '#FFFC14',
      contactSectionHeaderTextColor: "#000000",
      contactSectionHeaderBackgroundColor: "#FFFFFF",
      contactSectionIndexColor: "#000000",
      contactSectionIndexBackgroundColor: "#FFFFFF",
      messageFieldTextColor: "#FFFC14",
      messageFieldBackgroundColor: "#FFFFFF",
      sendButtonCopy: "Send",
      sendButtonTextColor: "#990000",
      bottomViewBorderColor: "#CCCCCC",
      bottomViewBackgroundColor: "#WWWWWW",
      sharePageBackgroundColor: "#990000",
      sharePageIconColor: "#000000",
      sharePageIconTextColor: "#FFFFFF",
      sharePageExplanationTextColor: "#FFFC14"
    };
    mave.setDisplayOptions(displayOptions);
```

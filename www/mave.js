var maveExport = {};

maveExport.setupSharedInstanceWithApplicationID = function (applicationId) {
  var successCallback = function () {
      console.log('init success');
  };
  var errorCallback = function () {
      console.log('init error');
  };
  cordova.exec(successCallback, errorCallback, "Mave", "setupSharedInstanceWithApplicationID", [applicationId]);
};

maveExport.identifyUser = function (userData) {
  var successCallback = function () {
      console.log('identifyUser success');
  };
  var errorCallback = function () {
      console.log('identifyUser error');
  };
  var userId = userData.userId;
  var firstName = userData.firstName;
  var lastName = userData.lastName;
  var email = userData.email;
  var phone = userData.phone;
  cordova.exec(successCallback, errorCallback, "Mave", "identifyUser", [userId, firstName, lastName, email, phone]);
};

maveExport.getReferringUser = function (successCallback) {
  var errorCallback = function ( data ) {
      console.log('getReferringUser error');
  };
  cordova.exec(successCallback, errorCallback, "Mave", "getReferringUser", []);
};

maveExport.identifyAnonymousUser = function () {
  var successCallback = function () {
      console.log('identifyAnonymousUser success');
  };
  var errorCallback = function () {
      console.log('identifyAnonymousUser error');
  };
  cordova.exec(successCallback, errorCallback, "Mave", "identifyAnonymousUser", []);
};

maveExport.presentInvitePageModally = function (userData) {
  var successCallback = function () {
      console.log('presentInvitePageModally success');
  };
  var errorCallback = function () {
      console.log('presentInvitePageModally error');
  };
  cordova.exec(successCallback, errorCallback, "Mave", "presentInvitePageModallyWithBlock", []);
};

maveExport.trackSignup = function () {
  var successCallback = function () {
      console.log('trackSignup success');
  };
  var errorCallback = function () {
      console.log('trackSignup error');
  };
  cordova.exec(successCallback, errorCallback, "Mave", "trackSignup", []);
};


/* Configuration */
maveExport.setBackButtonTitle = function (title) {
  var successCallback = function () {
      console.log('setBackButtonTitle success');
  };
  var errorCallback = function () {
      console.log('setBackButtonTitle error');
  };
  cordova.exec(successCallback, errorCallback, "Mave", "setBackButtonTitle", [title]);
};

maveExport.setBackButtonTintColor = function (color) {
  var successCallback = function () {
      console.log('setBackButtonTintColor success');
  };
  var errorCallback = function () {
      console.log('setBackButtonTintColor error');
  };
  cordova.exec(successCallback, errorCallback, "Mave", "setBackButtonTintColor", [color]);
};

maveExport.setDisplayOptions = function (displayOptions) {
  displayOptions = displayOptions || {};
  var successCallback = function () {
      console.log('setDisplayOptions success');
  };
  var errorCallback = function () {
      console.log('setDisplayOptions error');
  };
  cordova.exec(successCallback, errorCallback, "Mave", "setNavigationBarOptions", [
    displayOptions.navigationBarTitleCopy,
    displayOptions.navigationBarTitleTextColor,
    displayOptions.navigationBarBackgroundColor,
    displayOptions.navigationBarCancelButtonTitle,
    displayOptions.navigationBarCancelButtonTintColor
  ]);
  cordova.exec(successCallback, errorCallback, "Mave", "setInviteExplanationOptions", [
    displayOptions.inviteExplanationTextColor,
    displayOptions.inviteExplanationCellBackgroundColor
  ]);
  cordova.exec(successCallback, errorCallback, "Mave", "setContactOptions", [
    displayOptions.contactNameTextColor,
    displayOptions.contactDetailsTextColor,
    displayOptions.contactSeparatorColor,
    displayOptions.contactCellBackgroundColor,
    displayOptions.contactCheckmarkColor
  ]);
  cordova.exec(successCallback, errorCallback, "Mave", "setContactSectionOptions", [
    displayOptions.contactSectionHeaderTextColor,
    displayOptions.contactSectionHeaderBackgroundColor,
    displayOptions.contactSectionIndexColor,
    displayOptions.contactSectionIndexBackgroundColor
  ]);
  cordova.exec(successCallback, errorCallback, "Mave", "setMessageSectionOptions", [
    displayOptions.messageFieldTextColor,
    displayOptions.messageFieldBackgroundColor,
    displayOptions.sendButtonCopy,
    displayOptions.sendButtonTextColor,
    displayOptions.bottomViewBorderColor,
    displayOptions.bottomViewBackgroundColor
  ]);
  cordova.exec(successCallback, errorCallback, "Mave", "setSharePageOptions", [
    displayOptions.sharePageBackgroundColor,
    displayOptions.sharePageIconColor,
    displayOptions.sharePageIconTextColor,
    displayOptions.sharePageExplanationTextColor
  ]);
};

module.exports = maveExport;

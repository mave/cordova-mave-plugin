var maveExport = {};

maveExport.setupSharedInstanceWithApplicationID = function (applicationId, successCallback, errorCallback) {
  successCallback = successCallback || function () {
      console.log('init success');
  };
  errorCallback = errorCallback || function (errorMessage) {
      console.log('init error: ' + errorMessage);
  };
  if ( applicationId === undefined ) {
    errorCallback('No Application ID was passed in.');
  } else {
    cordova.exec(successCallback, errorCallback, "Mave", "setupSharedInstanceWithApplicationID", [applicationId]);
  }
};

maveExport.identifyUser = function (userData, successCallback, errorCallback) {
  successCallback = successCallback || function () {
      console.log('identifyUser success');
  };
  errorCallback = errorCallback || function (errorMessage) {
      console.log('identifyUser error: ' + errorMessage);
  };
  var userID = userData.userID;
  var firstName = userData.firstName;
  var lastName = userData.lastName;
  var email = userData.email;
  var phone = userData.phone;
  if ( userID === undefined ) {
    errorCallback('userID is required');
  } else if ( firstName === undefined ) {
    errorCallback('firstName is required');
  } else {
    cordova.exec(successCallback, errorCallback, "Mave", "identifyUser", [userID, firstName, lastName, email, phone]);
  }
};

maveExport.getReferringData = function (successCallback, errorCallback) {
  successCallback = successCallback || function () {
      console.log('getReferringData success');
  };
  errorCallback = errorCallback || function (errorMessage) {
      console.log('getReferringData error: ' + errorMessage);
  };
  cordova.exec(successCallback, errorCallback, "Mave", "getReferringData", []);
};

maveExport.identifyAnonymousUser = function (successCallback, errorCallback) {
  successCallback = successCallback || function () {
      console.log('identifyAnonymousUser success');
  };
  errorCallback = errorCallback || function (errorMessage) {
      console.log('identifyAnonymousUser error: ' + errorMessage);
  };
  cordova.exec(successCallback, errorCallback, "Mave", "identifyAnonymousUser", []);
};

maveExport.presentInvitePageModally = function (successCallback, errorCallback) {
  successCallback = successCallback || function () {
    console.log('presentInvitePageModally success');
  };
  errorCallback = errorCallback || function (errorMessage) {
      console.log('presentInvitePageModally error: ' + errorMessage);
  };
  cordova.exec(successCallback, errorCallback, "Mave", "presentInvitePageModallyWithBlock", []);
};

maveExport.trackSignup = function (successCallback, errorMessage) {
  successCallback = successCallback || function () {
      console.log('trackSignup success');
  };
  errorCallback = errorCallback || function (errorMessage) {
      console.log('trackSignup error: ' + errorMessage);
  };
  cordova.exec(successCallback, errorCallback, "Mave", "trackSignup", []);
};


/* Configuration */
maveExport.setDisplayOptions = function (displayOptions, successCallback, errorCallback) {
  displayOptions = displayOptions || {};
  successCallback = successCallback || function () {
    console.log('setDisplayOptions success');
  };
  errorCallback = errorCallback || function (errorMessage) {
    console.log('setDisplayOptions error: ' + errorMessage);
  };
  cordova.exec(function () {
    cordova.exec(function () {
      cordova.exec(function () {
        cordova.exec(function () {
          cordova.exec(function () {
            cordova.exec(successCallback, errorCallback, "Mave", "setSharePageOptions", [
              displayOptions.sharePageBackgroundColor,
              displayOptions.sharePageIconColor,
              displayOptions.sharePageIconTextColor,
              displayOptions.sharePageExplanationTextColor
            ]);
          }, errorCallback, "Mave", "setMessageSectionOptions", [
            displayOptions.messageFieldTextColor,
            displayOptions.messageFieldBackgroundColor,
            displayOptions.sendButtonCopy,
            displayOptions.sendButtonTextColor,
            displayOptions.bottomViewBorderColor,
            displayOptions.bottomViewBackgroundColor
          ]);
        }, errorCallback, "Mave", "setContactSectionOptions", [
          displayOptions.contactSectionHeaderTextColor,
          displayOptions.contactSectionHeaderBackgroundColor,
          displayOptions.contactSectionIndexColor,
          displayOptions.contactSectionIndexBackgroundColor
        ]);
      }, errorCallback, "Mave", "setContactOptions", [
        displayOptions.contactNameTextColor,
        displayOptions.contactDetailsTextColor,
        displayOptions.contactSeparatorColor,
        displayOptions.contactCellBackgroundColor,
        displayOptions.contactCheckmarkColor
      ]);
    }, errorCallback, "Mave", "setInviteExplanationOptions", [
      displayOptions.inviteExplanationTextColor,
      displayOptions.inviteExplanationCellBackgroundColor
    ]);
  }, errorCallback, "Mave", "setNavigationBarOptions", [
    displayOptions.navigationBarTitleCopy,
    displayOptions.navigationBarTitleTextColor,
    displayOptions.navigationBarBackgroundColor,
    displayOptions.navigationBarCancelButtonTitle,
    displayOptions.navigationBarCancelButtonTintColor
  ]);
};

module.exports = maveExport;

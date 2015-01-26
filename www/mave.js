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

module.exports = maveExport;

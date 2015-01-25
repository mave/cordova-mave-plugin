var maveExport = {};

maveExport.init = function (applicationId) {
  var successCallback = function () {
      console.log('success');
  };
  var errorCallback = function () {
      console.log('error');
  };
  cordova.exec(successCallback, errorCallback, "Mave", "init", [applicationId]);
};

module.exports = maveExport;

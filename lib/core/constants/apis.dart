class Apis {
  static const baseUrl = "https://aljawabtaxi.rosecaptain.com/api/";

  /// Authentication
  static const loginOrSignupDriver = "auth/driver/login";
  static const verifyDriver = "auth/driver/verify-otp";
  static const resendOTPCode = "auth/driver/resendOTP";

  /// Add Driver Data
  static const completeDriverProfile = "drivers";

  /// Add Passengers
  static const addPassengers = "passengers";
  static const allPassengers = "passengers/getAll";
  // concatenate baseurl with endpoints
  static Uri getEndpoint(String endpoint) => Uri.parse(baseUrl + endpoint);
}

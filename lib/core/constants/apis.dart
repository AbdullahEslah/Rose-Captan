class Apis {
  static const baseUrl = "https://aljawabtaxi.rosecaptain.com/api/";

  static const loginOrSignupDriver = "auth/driver/login";
  static const verifyDriver = "auth/driver/verify-otp";
  static const resendOTPCode = "auth/driver/resendOTP";
  static const completeDriverProfile = "drivers";

  // concatenate baseurl with endpoints
  static Uri getEndpoint(String endpoint) => Uri.parse(baseUrl + endpoint);
}

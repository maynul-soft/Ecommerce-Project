class Urls{
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';
  static const String registrationUrl = '$_baseUrl/auth/signup';
  static const String verifyOtpUrl = '$_baseUrl/auth/verify-otp';
  static const String loginUrls = '$_baseUrl/auth/login';
  static const String resendOtpUrl = '$_baseUrl/auth/resend-otp';
  static const String homeSliderUrl = '$_baseUrl/slides';
  static String productCatagoryUrl({required int count, required int page }) => '$_baseUrl/categories?count=${count}&page=${page}';
}
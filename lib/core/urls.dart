class Urls{
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';
  static const String registrationUrl = '$_baseUrl/auth/signup';
  static const String verifyOtpUrl = '$_baseUrl/auth/verify-otp';
  static const String loginUrls = '$_baseUrl/auth/login';
  static const String resendOtpUrl = '$_baseUrl/auth/resend-otp';
  static const String homeSliderUrl = '$_baseUrl/slides';
  static const String addToCartUrl = '$_baseUrl/cart';
  static const String getCartItemUrl = '$_baseUrl/cart';
  static const String createReviewUrl = '$_baseUrl/review';
  static const String wishListUrl = '$_baseUrl/wishlist';
  static const String addToWishlistUrl = '$_baseUrl/wishlist';
  static const String createOrderUrl = '$_baseUrl/order';
  static  String productCategoryUrl({required int count, required int page }) => '$_baseUrl/categories?count=$count&page=$page';
  static String productListByCategory({required int count, required int page, required String categoryId}) => '$_baseUrl/products?count=$count&page=$page&category=$categoryId';
  static String productByTagUrl({required String tag}) => '$_baseUrl/products?tag=$tag';
  static String productDetailsUrl({required String id}) => '$_baseUrl/products/id/$id';
  static String updateCartItemUrl({required String id}) => '$_baseUrl/cart/$id';
  static String deleteItemUrl({required String id}) => '$_baseUrl/cart/$id';
  static String productReviewUrl({required String id}) => '$_baseUrl/reviews?count=${500}&product=$id';
}
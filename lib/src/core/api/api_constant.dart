class ApiPaymentConstant {
  static const baseUrl = 'https://accept.paymob.com/api';

  static const getAuthToken = '$baseUrl/api/auth/tokens';

  static const paymentApiKey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TnpJME5URTJMQ0p1WVcxbElqb2lNVFk0T0Rrd09UZ3dNaTR5TURNeU1Ea2lmUS53ZDFCTFg0RXhyMmZHeEw1SFZxQjZtSTB1dk9UWUhLQWxySWVqcUZjSjRzS1NyNjAyTmUtQ3lqNDhObm1ibVQzNXNWT2NwTkZ4Q2lIMGlYaUt1TWFSQQ==';

  static const getOrderId = '$baseUrl/ecommerce/orders';
  static const getPaymentToken = '$baseUrl/acceptance/payment_keys';
  static const getPayment = '$baseUrl/acceptance/payments/pay';

  static String visaUrl =
      '$baseUrl/acceptance/iframes/744284?payment_token=$finalTokenPayment';

  /// online card 3678430
  /// mobile wallet 3706992

  ///
  static String paymentAuthToken = '';
  static String paymentOrderId = '';
  static const int integrationIdCard = 3678430;
  static const int integrationIdMobileWallet = 3706992;
  static String refCode = '';
  static String finalTokenPayment = '';
  static String mobileWalletIframe = '';
}

class ApiMapConstant {
  static const String apiKey = 'AIzaSyDjjZzMmPfqAB8xbfhXhr2yiEaJ8n5EiDg';

  static const baseUrl = 'https://maps.googleapis.com/maps/api/place';

  static const getPlaceId = '$baseUrl/autocomplete/json';
  static const getPlaceDetails = '$baseUrl/details/json';
}

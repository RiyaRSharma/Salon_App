import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService({String baseUrl = "http://localhost:5000/api/"})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  // Register user
  Future<Response> signUpUser(String email, String password, String phone) async {
    try {
      Response response = await _dio.post(
        'users',
        data: {
          "email": email,
          "password": password,
          "phone": phone,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Save booking
  Future<Response> saveBooking(Map<String, dynamic> bookingData) async {
    try {
      Response response = await _dio.post(
        'bookings',
        data: bookingData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:perfection_company/models/user.dart';

class UserRepository {
  static const String _baseUrl = 'https://reqres.in/api/users';

  Future<List<User>> fetchUsers(int page) async {
    final response = await http.get(Uri.parse('$_baseUrl?page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['data'] as List).map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> fetchUserDetail(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data['data']);
    } else {
      throw Exception('Failed to load user details');
    }
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'http://127.0.0.1:8000/api/v1';
  // 192.168.1.2 is my IP, change with your IP address
  String? token;
  Network({
    this.token,
  });

  Future<void> _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var storedToken = localStorage.getString('token');
    // print(storedToken);
    if (storedToken != null) {
      // print(storedToken);
      token = jsonDecode(storedToken) as String?;
    }
  }

  Future<http.Response> auth(data, apiURL) async {
    await _getToken();
    var fullUrl = _url + apiURL;
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  Future<http.Response> getData(apiURL) async {
    await _getToken();
    var fullUrl = _url + apiURL;
    return await http.get(
      Uri.parse(fullUrl),
      headers: _setHeaders(),
    );
  }

  Map<String, String> _setHeaders() {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Network copyWith({
    String? token,
  }) {
    return Network(
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    if (token is Map<String, dynamic>) {
      return <String, dynamic>{
        'token': token,
      };
    } else {
      return <String, dynamic>{};
    }
  }

  factory Network.fromMap(Map<String, dynamic> map) {
    return Network(
      token: map['token'] != null ? map['token'] as String : null,
      // Other properties initialization if needed
    );
  }

  String toJson() => json.encode(toMap());

  factory Network.fromJson(String source) => Network.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Network(token: $token)';

  @override
  bool operator ==(covariant Network other) {
    if (identical(this, other)) return true;
  
    return 
      other.token == token;
  }

  @override
  int get hashCode => token.hashCode;
}

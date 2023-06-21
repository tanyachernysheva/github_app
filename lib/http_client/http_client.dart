import 'dart:convert' as convert;
import 'dart:developer';

import 'package:github_app/routes.dart';
import 'package:http/http.dart' as http;

final class HttpClient {
  static HttpClient? _instance;

  factory HttpClient() {
    return _instance ??= HttpClient._();
  }

  HttpClient._();

  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    final Uri uri = Uri.https(
      Api.baseUrl,
      url,
      query,
    );

    final response = await http.get(uri);

    log('[${response.statusCode}] - [${response.request?.method}] [${response.request?.url}]\nBody: ${response.body}');

    final json = convert.jsonDecode(response.body);

    return json;
  }
}

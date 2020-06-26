import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper({this.url});

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode >= 200 || response.statusCode < 400) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      print(response.statusCode);
      return null;
    }
  }
}

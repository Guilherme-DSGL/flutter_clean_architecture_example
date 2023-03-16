import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const kApiUrl = 'http://numbersapi.com';

class HttpClientAdapter {
  Future<Response> get(String path, {Map<String, String>? headers}) async {
    final url = Uri.parse(path);
    final res = await http.get(url, headers: headers);
    return res;
  }
}

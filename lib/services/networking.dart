import 'dart:io';

import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'dart:convert';

class NetWorkHelper {
  final String url;
  final dynamic body;
  NetWorkHelper(this.url, this.body);

  Future getData() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(client);
    print(jsonEncode(body));
    Response response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode(body));
    print(response.reasonPhrase);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else
      print(response.statusCode);
  }
}

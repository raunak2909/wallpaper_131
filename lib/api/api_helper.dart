import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper {

  Future<dynamic> getApi(
      {required String url, Map<String, String>? mHeader}) async {
    var res = await http.get(Uri.parse(url),
        headers: mHeader ??
            {
              "Authorization": "nXWH9BLpCYtVtyjDTbJB3Hf20uneSxZcYisVLVmNDV4PamGm6EeVDgZm"
            });

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return null;
    }
  }
}

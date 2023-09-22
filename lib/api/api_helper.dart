import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/api/my_exceptions.dart';

class ApiHelper {

  Future<dynamic> getApi({required String url, Map<String, String>? mHeader}) async {
    //var mData;

    try{
      var res = await http.get(Uri.parse(url),
          headers: mHeader ??
              {
                "Authorization": "nXWH9BLpCYtVtyjDTbJB3Hf20uneSxZcYisVLVmNDV4PamGm6EeVDgZm"
              });

      return returnDataResponse(res);

    } on SocketException{
      throw FetchDataException(body: "Internet Error");
    }

  }


  Future<dynamic> postApi({required String url, Map<String, String>? mHeader, Map<String, String>? body}) async {
    //var mData;

    try{
      var res = await http.post(Uri.parse(url),
          body: body,
          headers: mHeader ??
              {
                "Authorization": "nXWH9BLpCYtVtyjDTbJB3Hf20uneSxZcYisVLVmNDV4PamGm6EeVDgZmm"
              });

      return returnDataResponse(res);

    } on SocketException{
      throw FetchDataException(body: "Internet Error");
    }

  }



  dynamic returnDataResponse(http.Response res){
    switch(res.statusCode){

      case 200:
        var mData = res.body;
        print(mData);
        return jsonDecode(mData);

      case 400:
        throw BadRequestException(body: res.body.toString());

      case 401:
      case 403:
      case 407:
        throw UnAuthorisedException(body: res.body.toString());

      case 500:
      default:
        throw FetchDataException(body: "Error while communicating to server");

    }
  }

}

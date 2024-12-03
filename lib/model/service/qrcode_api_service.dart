import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_generator/model/repository/qrcode_input_data.dart';

class QrcodeApiService {
  Future<http.Response> fetchQrcode(String qrcodeParameters) async {
    String url = 'https://image-charts.com/chart?$qrcodeParameters';
    print(url);

    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        print('response: ${response.statusCode}');

        throw 'error';
      }
      return response;
    } catch (e) {
      print('error ${e.toString}');
      throw 'error';
    }
  }
}

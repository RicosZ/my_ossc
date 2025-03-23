import 'package:dio/dio.dart';
import '../models/new_ossc_data_model.dart';

class NewApi {
  var dio = Dio();
  String subUrl = 'https://my-ossc-be.vercel.app';

  Future<OsscNew> getInformation({
    String? act,
    String? desc,
    String? search,
    int? limit = 100,
  }) async {
    // print(file.readAsBytesSync());
    try {
      final response = await dio.get('$subUrl/transection', queryParameters: {
        'act': act,
        'desc': desc,
        'search': search,
        'limit': limit
      });
      final statusCode = response.statusCode;
      final body = response.data;

      if (statusCode == 200) {
        print(statusCode);
        // print(body);
        return OsscNew.fromJson(body);
      }
    } catch (e) {
      print(e);
    }
    return OsscNew(success: false, data: []);
  }

  Future addInformation({
    String? date,
    String? customer,
    String? company,
    String? district,
    String? tel,
    String? act,
    String? type,
    String? desc,
    String? cost,
    String? slipUrl,
    String? doc,
    String? requestStaff,
  }) async {
    // print(file.readAsBytesSync());
    try {
      final response = await dio.post('$subUrl/transection/add', data: {
        'date': date,
        'customer': customer,
        'company': company,
        'district': district,
        'tel': tel,
        'act': act,
        'type': type,
        'desc': desc,
        'cost': cost,
        'slipUrl': slipUrl,
        'doc': doc,
        'requestStaff': requestStaff,
      });
      final statusCode = response.statusCode;
      final body = response.data;

      if (statusCode == 200) {
        print(statusCode);
        // print(body);
        return body;
      }
    } catch (e) {
      print(e);
    }
  }

  Future editInformation({required Object data}) async {
    // print(file.readAsBytesSync());
    try {
      final response = await dio.patch('$subUrl/transection/edit', data: data);
      final statusCode = response.statusCode;
      final body = response.data;

      if (statusCode == 200) {
        print(statusCode);
        print(body);
        return body;
      }
    } catch (e) {
      print(e);
    }
  }

  Future removeTempFile({required String fileName}) async {
    // print(file.readAsBytesSync());
    try {
      final response = await dio.get('$subUrl/removefile/$fileName');
      final statusCode = response.statusCode;
      final body = response.data;

      if (statusCode == 200) {
        print(statusCode);
        print(body);
        return body;
      }
    } catch (e) {
      print(e);
    }
  }

  Future exportDate({
    String? act,
    String? desc,
    required String dateBefor,
    required String dateAfter,
  }) async {
    try {
      final response = await dio.post('$subUrl/transection/export', data: {
        'act': act,
        'desc': desc,
        'dateBefor': dateBefor,
        'dateAfter': dateAfter,
      });
      final statusCode = response.statusCode;
      final body = response.data;

      if (statusCode == 200) {
        print(statusCode);
        print(body);
        return body;
      }
    } catch (e) {
      print(e);
    }
  }
}

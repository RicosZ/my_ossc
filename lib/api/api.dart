import 'package:dio/dio.dart';
import 'package:my_ossc/models/ossc_user_model.dart';
import '../models/district_model.dart';
import '../models/ossc_data_model.dart';
// import '../models/data_model.dart';

class Api {
  var dio = Dio();

  // static Future<List<CallData>> fetchAll() async {
  Future<Ossc> fetchDataAll() async {
    try {
      final response = await dio.get(
          'https://script.google.com/macros/s/AKfycbwj5iwizfbBLuz2Y8hPZmUaeykgrOQb3cFkDvRThBWNuCQqS7qlkoYIYCgGdnmqLruP/exec');
      // final body = response.data;
      if (response.statusCode == 200) {
        // List<dynamic> jsonResponse = jsonDecode(response.data);
        // return jsonResponse.map((e) => CallData.fromJson(e)).toList();
        return Ossc.fromJson(response.data);
      }
    } catch (e) {}
    return Ossc(
      success: false,
    );
  }

  Future<OsscUser> fetchAllUser() async {
    try {
      final response = await dio.get(
          'https://script.google.com/macros/s/AKfycbwk8vlOaIBrbbd8NRAhDKU4qV9RyGJ0UqgMcL2s7_rdkTTVAH3ukSzdxmHncITk4VL1/exec');
      // final body = response.data;
      if (response.statusCode == 200) {
        // List<dynamic> jsonResponse = jsonDecode(response.data);
        // return jsonResponse.map((e) => CallData.fromJson(e)).toList();
        return OsscUser.fromJson(response.data);
      }
    } catch (e) {}
    return OsscUser(
      success: false,
      data: [],
    );
  }

  Future<List<District>> getDistrict() async {
    try {
      final response = await dio
          .get('https://epofhospital.github.io/vetcaare-data/api_amphure.json');
      final statuCode = response.statusCode;
      final body = response.data;
      if (statuCode == 200) {
        return districtFromJson(body);
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}

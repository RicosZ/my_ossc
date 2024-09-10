// import 'dart:io';

import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
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

  Future uploadFile({
    required Uint8List file,
    required String fileName,
    required String token,
    required String directory,
  }) async {
    // print(file.readAsBytesSync());
    try {
      // getdata() async => {
      //       "token":
      //           'EwBoA8l6BAAUs5+HQn0N+h2FxWzLS31ZgQVuHsYAAZ1gaR3+idVA0dbf4ddHIkv47X/stXsuZQpm5EQdAJwfgSe7wCmanW5adbE2Ij3LWFu+NQ31yu7VPu8vtIFTEjP9IDb4u5V4zNKECU1lSIOcDXnHeHHwe/ghxn3PLvv2p8Qhk4MFK0tEWosteXtUeZBpDEF/g6p0KuK3vNYItJoYwn3PC+DtZsic5FL7mR/sD3krkz5Y/9NHULaI6MvAYXGi+MgKuLIQjJSx0ej0QVMQmB7ripZK+KoXHp6V4qn/qYoSbDRNSXAvy/f/WPs945koDy0vdjM7fYMxQqdNjYlyp8eMsehbVzyQ+C8BgqeZoQTfXq1Pu6XB2yUMItZjFJYDZgAACMbZeI47BuJAOAJae20McYhqiDmytECO5+N/99G6RAiItD0vNusO2Mkqu/kcZBA0mqnt4TBVKMKA92UFbRUcCAZS1srbWRVRryva4jwhvoHqxKxlJtfTax4gem1Dq6MtSkHNsiSXyfxgpeSvczfNytg75rU3tUpLUe4/HcN8QCOhdIbVp7XcE8FVrGv2L+CODSuQgwITIT0mRP2To7JIyyZFmRVDoeI21YDpu3InxRaEfRvju3QMlNlgWx4LNqBbwBuM5deDIgkDlykT0SHqJ0McBRxYztwwvglHKgg78kvGTZFeATh6XYYyOfJ7ujc0292RQkq0vIPzUEINALjRYfqsKCo6j/S0aDJrT3RC/r546KyM850VvrAJZhaUcGJXhbC4LA6xjoM3LjvBtbIYXanaPKK2GInBN9rs6W4LjzmCqZ5Kn21F9js2Z+jz9+sXutOeWKemPBhfVaW9Tp+VXXS5k8GGuRbqQjALD9V46br+G1z4Vi0bgLgYwQkzT4PdJlzZ6+Jdd6+lHZZcgTXjy7EW3uBqvjjs9l2cq4EUQGRLbeBkUP5L0+cN7luFWhrhUHA/YbdaPiPkjZXwt2HuIbaY5FrR7htCY5PrvDt5VpX9LuJdSWmenwRwgSWell8DzUDhrchUng/zmat06a9d6mJ9taIGVCSM7VmiIM2ylYXVerW2r09whn/hcOCJB7M4riX5xL81xQnNMv5IxRdqGIAFELYvyCpqA5oIOn9xegZ6oFGucajmxDjsGgaKs47NxRw2cwI=',
      //       'directory': 'Documents/doc',
      //       "file": file,
      //       'fileName': 'test.pdf'
      //     };
      var fd = FormData.fromMap({
        "token": token,
        'directory': directory,
        "file": MultipartFile.fromBytes(file, filename: fileName),
        'fileName': fileName
      });
      final response = await dio.put(
        'https://ossc-api.onrender.com/upload',
        data: fd,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
          // extra: {
          //   'data': getdata
          // },
          //     // contentType: 'multipart/form-data',
          //     headers: {
          //       'enctype': 'multipart/form-data',
          //       'Content-Type': 'multipart/form-data'
          // }
        ),
      );
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

  Future checkExpiredToken({required String accessToken}) async {
    print('checking-------------------');
    try {
      final response = await dio.get(
          'https://graph.microsoft.com/v1.0/me/messages',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
      final statusCode = response.statusCode;
      // final body = response.data;
      if (statusCode == 200) {
        return false;
      }
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future reNewAccrssToken({required String refreshToken}) async {
    print('request------------------------');
    try {
      final response = await dio.post(
        'https://ossc-api.onrender.com/renew-accesstoken',
        data: {'token': refreshToken},
      );
      final statusCode = response.statusCode;
      final body = response.data;

      if (statusCode == 200) {
        print('aaaaaaaccccccccccccccccccccccccc');
        GetStorage().write('refreshToken', body['refresh_token']);
        // print(GetStorage().read('refreshToken'));
        // print('token: ${body['access_token']}');
        log(GetStorage().read('refreshToken'));
        return body['access_token'];
      }
    } catch (e) {
      inspect(e);
    }
  }

  Future fetchFile({
    required String refreshToken,
    required String path2File,
    required bool isFile
  }) async {
    try {
      final response = await dio.post('https://ossc-api.onrender.com/fetch', data: {
        'token': refreshToken,
        'path2File': path2File,
        'file': isFile
      });
      final statusCode = response.statusCode;
      final body = response.data;
      if (statusCode == 200) {
        print('aaaaaaacc------------------ccccccccccc');
        print(body);
        return true;
      }
    } catch (e) {
      inspect(e);
    }
  }
}

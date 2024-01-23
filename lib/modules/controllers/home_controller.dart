import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gsheets/gsheets.dart';
import 'package:my_ossc/models/ossc_user_model.dart';

import '../../api/api.dart';
import '../../constants/credentials.dart';
import '../../routes/app_routes.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var osscUser = <OsscUserData>[].obs;

  final key = GlobalKey<FormBuilderState>();

  final gsheets = GSheets(Credential.sheet);
  Spreadsheet? sheet;
  Worksheet? worksheet;
  @override
  Future<void> onInit() async {
    sheet = await gsheets.spreadsheet(Credential.user);
    worksheet = sheet!.worksheetByTitle('sheet1');
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}

  var auth = true.obs;

  login() async {
    // final cryptPassword = Crypt.sha256(
    //     key.currentState!.fields['password']?.value,
    //     rounds: 512,
    //     salt: 'ossckk');
    // // print(cryptPassword.toString());
    isLoading(true);
    try {
      final listUser = await Api().fetchAllUser();
      osscUser.assignAll(listUser.data);
      osscUser.firstWhere((element) {
        if (element.username == key.currentState!.fields['username']?.value &&
            element.password == key.currentState!.fields['password']?.value) {
          GetStorage().write('name', element.username);
          auth(true);
          return true;
        }
        auth(false);
        return false;
      });
      if (auth.value == true) {
        print('success');
        Get.toNamed(Routes.listOfContent);
      } else {
        print('error');
      }

      isLoading(false);
    } catch (e) {
      //NOTE - Error
      print(e);
    }
  }

  // login() async {

  // }

  addInformation() async {
    // worksheet!.values.insertRow(data.length + 2, [
    //   TimeFormat()
    //       .getDatetime(date: '${key.currentState?.fields['date']?.value}'),
    //   's',
    //   act.value,
    //   'x',
    //   key.currentState?.fields['desc']?.value,
    //   result.value,
    //   key.currentState?.fields['note']?.value,
    // ]).then((value) => getInformation());
    // Get.back();
  }
}

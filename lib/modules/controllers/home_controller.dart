import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gsheets/gsheets.dart';
import 'package:my_ossc/api/new_api.dart';
import 'package:my_ossc/constants/notosansthai.dart';
import 'package:my_ossc/models/ossc_user_model.dart';

import '../../api/api.dart';
import '../../constants/credentials.dart';
import '../../routes/app_routes.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var osscUser = <OsscUserData>[].obs;

  final key = GlobalKey<FormBuilderState>();

  final gsheets = GSheets(Credential.sheet);
  Spreadsheet? sheet;
  Worksheet? worksheet;
  RxBool obscure = true.obs;
  @override
  Future<void> onInit() async {
    // await addInformation();
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
          GetStorage().write('no', element.no);
          GetStorage().write('name', element.name);
          GetStorage().write('refreshToken', element.token);
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
      isLoading(false);
      //NOTE - Error
      Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Container(
            height: 200,
            width: 160,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Icon(
                    Icons.error,
                    size: 64,
                    color: Colors.red,
                  ),
                ),
                const Text('ชื่อผู้ใช้หรือรหัสผ่านผิด', style: NotoSansThai.h2),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('ตกลง',
                      style: NotoSansThai.h3.copyWith(color: Colors.white)),
                )
              ],
            )),
      ));
      print(e);
    }
  }

  // login() async {

  // }

  addInformation() async {
    try {
      final res = NewApi().editInformation(data: {
        'receiveNumber': 'E1/2567',
        'requestStaff': 'aaaaaaaaaaaaaaaaaaaaaaaa'
      });
    } catch (e) {
      print(e);
    }
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

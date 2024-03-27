import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:get_storage/get_storage.dart';
import 'package:signature/signature.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:universal_io/io.dart';

import '../../api/api.dart';
import '../../api/services/time_format.dart';
import '../../constants/credentials.dart';
import '../../models/district_model.dart';
import '../../models/ossc_data_model.dart';

// const _clientId = "1005734918784-qj24e6gjq99omrv7kf33um3k3plid0om.apps.googleusercontent.com";
// const _scopes = ['https://www.googleapis.com/auth/drive.file'];

class ListOfContentController extends GetxController {
  var name = 'กิตติชัย'.obs;
  var osscData = <OsscData>[].obs;
  var osscFilterData = <OsscData>[].obs;
  var isLoading = true.obs;
  var pdfFileUrl = Uint8List(0).obs;
  var signatureImage = Uint8List(0).obs;
  var open = false.obs;
  var pdfloading = true.obs;
  final ScrollController horizontal = ScrollController();
  final ScrollController vertical = ScrollController();
  late PdfViewerController pdfViewerController;
  // final PdfViewerController pdfController = PdfViewerController();
  final searchController = TextEditingController();
  final SignatureController signature = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  late Timer timer;

  final key = GlobalKey<FormBuilderState>();
  final List<String> listAnnotation = [
    'ยา',
    'อาหาร',
    'สถานพยาบาล',
    'เครื่องมือแพทย์',
    'ผลิตภัณฑ์สมุนไพร',
    'วัตถุออกฤทธิต่อจิตและประสาท',
    'เครื่องสำอาง',
    'กัญชง/กัญชาทางการแพทย์',
    'วัตถุอันตราย',
    'ยาเสพติด',
    'สถานประกอบการเพื่อสุขภาพ',
  ];
  final List<String> listAppointment = [
    'นัดตรวจ',
    'ไม่มีการตรวจ',
    'อำเภอตรวจ',
  ];
  final List<String> listFilterAct = [
    'ทั้งหมด',
    'ยา',
    'อาหาร',
    'สถานพยาบาล',
    'เครื่องมือแพทย์',
    'ผลิตภัณฑ์สมุนไพร',
    'วัตถุออกฤทธิต่อจิตและประสาท',
    'เครื่องสำอาง',
    'กัญชง/กัญชาทางการแพทย์',
    'วัตถุอันตราย',
    'ยาเสพติด',
    'สถานประกอบการเพื่อสุขภาพ',
  ];
  final List<String> listDesc = [
    'ยื่นขอใบอนุญาตฯ',
    'ยื่นต่ออายุใบอนุญาตฯ',
    'ยื่นยกเลิกใบอนุญาตฯ',
    'ยื่นแก้ไข/เปลี่ยนแปลง/ ใบแทน ใบอนุญาตฯ',
    'ยื่นขออนุญาตโฆษณาฯ',
    'รับเอกสาร/ใบอนุญาตฯ',
    'ระบบ E-submission',
    'ชำระค่าปรับ',
    'ติดต่อ สอบถาม',
    'อื่นๆ'
  ];
  final List<String> listFilterDesc = [
    'ทั้งหมด',
    'ยื่นขอใบอนุญาตฯ',
    'ยื่นต่ออายุใบอนุญาตฯ',
    'ยื่นยกเลิกใบอนุญาตฯ',
    'ยื่นแก้ไข/เปลี่ยนแปลง/ ใบแทน ใบอนุญาตฯ',
    'ยื่นขออนุญาตโฆษณาฯ',
    'รับเอกสาร/ใบอนุญาตฯ',
    'ระบบ E-submission',
    'ชำระค่าปรับ',
    'ติดต่อ สอบถาม',
    'อื่นๆ'
  ];
  final List<String> listresultStatus = [
    'ผ่าน',
    'ไม่ผ่าน',
  ];
  final List<String> listReciveDoc = [
    'มารับเอง',
    'จัดส่งไปรษณีย์',
    'เปิดสิทธิ์แล้ว'
  ];

  final List<String> listHeader = [
    "ลำดับ",
    "วัน/เดือน/ปี",
    "เลขรับ",
    "ชื่อผู้รับอนุญาต/ชื่อผู้ติดต่อ",
    "ชื่อสถานประกอบการ",
    "อำเภอ",
    "เบอร์โทร",
    "พรบ.",
    "ประเภทสถานที่",
    "ธุรกรรม",
    "ค่าธรรมเนียม",
    "การชำระค่าธรรมเนียม",
    "เอกสารคำขอ",
    "เจ้าหน้าที่รับคำขอ",
    "สถานะการตรวจสถานที่",
    "เจ้าหน้าที่ตรวจสถานที่",
    "ตรวจสถานที่",
    "ผลตรวจ",
    "สถานะการตรวจ",
    "ส่งผลตรวจ",
    "เจ้าหน้าที่ส่งผลตรวจ",
    "เสนอพิจารณา",
    "เจ้าหน้าที่เสนอพิจารณา",
    "อนุมัติ",
    "ใบอนุญาต/เอกสาร",
    "เลขสถานที่",
    "เลขใบอนุญาต",
    "เลขใบอนุญาตประกอบกิจ",
    "เลขใบอนุญาตดำเนินการ",
    "เลขใบอนุญาตโฆษณา",
    "เลขใบอนุญาตผู้ดำเนินการสปา",
    "รับใบอนุญาต/รับเอกสาร",
    "วันที่รับ/วันที่จัดส่ง",
    "ชื่อผู้รับ/เลขพัสดุ",
    "สถานนะ"
  ];

  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
  final gsheets = GSheets(Credential.sheet);
  Spreadsheet? sheet;
  Spreadsheet? sheetUser;
  Worksheet? worksheet;
  Worksheet? worksheetUser;
  @override
  Future<void> onInit() async {
    // await testOnedrive();
    // _configureAmplify();
    name(GetStorage().read('name'));
    // data
    sheet = await gsheets.spreadsheet(Credential.ossc);
    worksheet = sheet!.worksheetByTitle('sheet1');
    // user
    sheetUser = await gsheets.spreadsheet(Credential.user);
    worksheetUser = sheetUser!.worksheetByTitle('sheet1');
    pdfViewerController = PdfViewerController();
    await getDistrict();
    getInformation();
    timer = Timer.periodic(const Duration(minutes: 2), (t) {
      loadInformation();
      // searchInformation();
    });
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    timer.cancel();
  }

  getInformation() async {
    isLoading(true);
    final da = await Api().fetchDataAll();
    osscData.assignAll(da.data ?? []);
    osscFilterData.assignAll(da.data ?? []);
    // osscData.sort((a, b) => b.no!.compareTo(a.no!));
    // final result = await Amplify.Storage.getUrl(
    //   key: 'image/013178100351BTF01999(1).jpeg',
    //   options: const StorageGetUrlOptions(
    //     accessLevel: StorageAccessLevel.guest,
    //     pluginOptions: S3GetUrlPluginOptions(
    //       validateObjectExistence: true,
    //       expiresIn: Duration(seconds: 15),
    //     ),
    //   ),
    // ).result;
    // print(result.url);
    isLoading(false);
  }

  loadInformation() async {
    final da = await Api().fetchDataAll();
    osscData.assignAll(da.data ?? []);
    osscFilterData.assignAll(da.data ?? []);
    // osscData.sort((a, b) => b.no!.compareTo(a.no!));
    if (!(desc.value == 'ทั้งหมด' || desc.value == '') ||
        !(act.value == 'ทั้งหมด' || act.value == '') ||
        !(searchController.value.text == '')) {
      searchInformation();
    }
  }

  var act = ''.obs;
  var result = ''.obs;
  setAct({required String dropdownDetail}) {
    act.value = dropdownDetail;
  }

  var desc = ''.obs;
  setDesc({required String dropdownDetail}) {
    desc.value = dropdownDetail;
  }

  var resultStatus = ''.obs;
  setResultStatus({required String dropdownDetail}) {
    resultStatus.value = dropdownDetail;
  }

  var sign = ''.obs;
  setSign({required String dropdownDetail}) {
    sign.value = dropdownDetail;
  }

  RxBool loading = false.obs;
  addInformation() async {
    loading(true);
    await loadInformation();
    // String nameReplace = '';
    // String imageReplace = '';
    if (imgName.value != '') {
      // imageReplace = imgName.value.replaceAll(' ', '-');
      // for (var i = 0; i < listFileName.length; i++) {
      await upload2Onedrive(
          rawPath: listPickedImage!.files.first.bytes!,
          fileName: listPickedImage!.files.first.name);
      // }
      // await upload2Ftp(pathFile: image!.path, folderName: 'image');
      // imgUrl.value = await uploadfile(
      //     folder: 'image', file: image!, fileName: imgName.value);
    }
    if (fileNames.value != '') {
      // nameReplace = fileNames.value.replaceAll(' ', '-');
      // listFile
      //     .map((file) async => await upload2Onedrive(
      //         rawPath: file.bytes!, fileName: result.files.first.name))
      //     .toList();
      for (var i = 0; i < listFileName.length; i++) {
        await upload2Onedrive(
            rawPath: listPickedFile!.files[i].bytes!,
            fileName: listPickedFile!.files[i].name);
      }
      // listFile
      //     .map((file) async => await uploadfile(
      //         folder: 'document', file: File(file.path!), fileName: file.name))
      //     .toList();
    }
    await worksheet!.values.insertRow(osscFilterData.length + 2, [
      osscFilterData.length + 1,
      TimeFormat()
          .getDatetime(date: '${key.currentState?.fields['date']?.value}'),
      key.currentState?.fields['recivedNumber']?.value,
      // 'E${osscData.length +1}/${DateTime.now().year+543}',
      key.currentState?.fields['name']?.value,
      key.currentState?.fields['company']?.value,
      selectDistrict.value,
      key.currentState?.fields['phone']?.value.toString(),
      act.value,
      key.currentState?.fields['loaclType']?.value,
      desc.value == 'อืนๆ'
          ? key.currentState?.fields['customDesc']?.value
          : desc.value,
      key.currentState?.fields['cost']?.value,
      // imgName.value,
      // '=IMAGE("${imgUrl.value}")',
      '',
      // imgUrl.value,
      imgName.value == '' ? '-' : imgName.value,
      fileNames.value == '' ? '-' : fileNames.value,
      name.value
    ]).then((value) async => {
          // await worksheet!.values.insertRow(
          //     osscData.length + 2,
          //     [
          //       isAppointment.value == 'ไม่มีการตรวจ'
          //           ? 'ไม่มี'
          //           : 'รอตรวจสถานที่',
          //       name.value,
          //       isAppointment.value == 'นัดตรวจ'
          //           ? key.currentState?.fields['appDate']?.value.toString()
          //           : isAppointment.value,
          //     ],
          //     fromColumn: 16),
          await worksheet!.values.insertRow(
              osscFilterData.length + 2, ['รับเข้า'],
              fromColumn: 37),
          loadInformation()
        });
    imgUrl('');
    loading(false);
    Get.back();
  }

  editInformation(int index) async {
    loading(true);
    // String nameReplace = '';
    // String imageReplace = '';
    if (imgName.value != '') {
      // imageReplace = imgName.value.replaceAll(' ', '-');
      // for (var i = 0; i < listFileName.length; i++) {
      await upload2Onedrive(
          rawPath: listPickedImage!.files.first.bytes!,
          fileName: listPickedImage!.files.first.name);
      // }
      // await upload2Ftp(pathFile: image!.path, folderName: 'image');
      // imgUrl.value = await uploadfile(
      //     folder: 'image', file: image!, fileName: imgName.value);
    }
    if (fileNames.value != '') {
      // nameReplace = fileNames.value.replaceAll(' ', '-');
      // listFile
      //     .map((file) async => await upload2Onedrive(
      //         rawPath: file.bytes!, fileName: result.files.first.name))
      //     .toList();
      for (var i = 0; i < listFileName.length; i++) {
        await upload2Onedrive(
            rawPath: listPickedFile!.files[i].bytes!,
            fileName: listPickedFile!.files[i].name);
      }
      // listFile
      //     .map((file) async => await uploadfile(
      //         folder: 'document', file: File(file.path!), fileName: file.name))
      //     .toList();
    }
    await worksheet!.values
        .insertRow(
            index + 1,
            [
              // osscData.length + 1,
              // TimeFormat().getDatetime(
              //     date: '${key.currentState?.fields['date']?.value}'),
              key.currentState?.fields['recivedNumber']?.value,
              // 'E${osscData.length +1}/${DateTime.now().year+543}',
              key.currentState?.fields['name']?.value,
              key.currentState?.fields['company']?.value,
              selectDistrict.value == ''
                  ? osscFilterData[index - 1].district
                  : selectDistrict.value,
              key.currentState?.fields['phone']?.value.toString(),
              act.value == '' ? osscFilterData[index - 1].act : act.value,
              key.currentState?.fields['loaclType']?.value,
              desc.value == ''
                  ? osscFilterData[index - 1].desc
                  : desc.value == 'อืนๆ'
                      ? key.currentState?.fields['customDesc']?.value
                      : desc.value,
              key.currentState?.fields['cost']?.value,
              // imgName.value,
              // '=IMAGE("${imgUrl.value}")',
              '',
              // imgUrl.value,
              imgName.value == ''
                  ? osscFilterData[index - 1].slipUrl
                  : imgName.value,
              fileNames.value == ''
                  ? osscFilterData[index - 1].doc
                  : fileNames.value,
              name.value
            ],
            fromColumn: 3)
        .then((value) => loadInformation());
    imgUrl('');
    loading(false);
    Get.back();
  }

  // placeTeamRecive(int index) async {
  //   await worksheet!.values
  //       .insertRow(
  //           index + 1,
  //           [
  //             name.value,
  //             TimeFormat().getDatetime(
  //                 date: DateTime.now().toString()),
  //           ],
  //           fromColumn: 33)
  //       .then((value) async {
  //     if (sign.value != 'จัดส่งไปรษณีย์' ||
  //         key.currentState?.fields['parcelNumber']?.value != '') {
  //       await updateSuccessStatus(index);
  //     }
  //     loadInformation();
  //   });
  //   Get.back();
  // }

  var imgName = ''.obs;
  File? image;
  var imgUrl = ''.obs;
  // var isPickedImage = false.obs;
  FilePickerResult? listPickedImage;
  pickImage() async {
    // isPickedImage(false);
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      listPickedImage = result;
      // File file = File(result.files.single.path!);
      imgName(result.files.single.name);
      // image = File(file.path);

      update();
      // isPickedImage(true);
    } else {
      // User canceled the picker
    }
  }

  FilePickerResult? listPickedFile;
  var listFileName = [].obs;
  var listFile = [].obs;
  var listFileUrl = [].obs;
  var fileNames = ''.obs;

  pickFile({BuildContext? context}) async {
    FilePickerResult? result =
        await FilePickerWeb.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      listPickedFile = result;
      // listFile.value = result.files.map((file) => file).toList();
      // listFile.value = result.files.map((file) => file).toList();
      listFileName.value = result.names.map((name) => name).toList();
      fileNames.value = listFileName.join(', ');
      // uploadFileToGoogleDrive(File(result.files.first.path!));
      // upload2Onedrive(context: context);
      // await upload2Onedrive(
      //     rawPath: result.files.first.bytes!,
      //     fileName: result.files.first.name);
    } else {
      // User canceled the picker
    }
  }

  RxString token = ''.obs;
  RxString filePath = ''.obs;

  getRequireInformation(
      {required String folder, required String fileName}) async {
    pdfloading(true);
    filePath('$folder/$fileName');
    try {
      await Api()
          .reNewAccrssToken(refreshToken: GetStorage().read('refreshToken'))
          .then((value) async {
        // GetStorage().write('accessToken', value);
        //ANCHOR -  update refreshtoke in sheet
        // log(GetStorage().read('no'));
        await worksheetUser?.values.insertRow(
            int.parse(GetStorage().read('no')) + 1,
            [GetStorage().read('refreshToken')],
            fromColumn: 6);
        token(value);
        update();
        // log(token.value);
      });
      pdfloading(false);
      // }
      // print(GetStorage().read('accessToken'));
      // return fileName;
    } catch (e) {
      // print(e);
    }
  }

  searchInformation() async {
    osscData.assignAll(osscFilterData.where((data) {
      if ((desc.value == 'ทั้งหมด' || desc.value == '') &&
          (act.value == 'ทั้งหมด' || act.value == '')) {
        return data.receiveNumber.contains(searchController.value.text) ||
            data.customer.contains(searchController.value.text) ||
            data.company.contains(searchController.value.text);
      }
      if (desc.value != 'ทั้งหมด' &&
          (act.value == 'ทั้งหมด' || act.value == '')) {
        return data.desc == desc.value &&
            (data.receiveNumber.contains(searchController.value.text) ||
                data.customer.contains(searchController.value.text) ||
                data.company.contains(searchController.value.text));
      }
      if (act.value != 'ทั้งหมด' &&
          (desc.value == 'ทั้งหมด' || desc.value == '')) {
        return data.act == act.value &&
            (data.receiveNumber.contains(searchController.value.text) ||
                data.customer.contains(searchController.value.text) ||
                data.company.contains(searchController.value.text));
      }
      return (data.desc == desc.value && data.act == act.value) &&
          (data.receiveNumber.contains(searchController.value.text) ||
              data.customer.contains(searchController.value.text) ||
              data.company.contains(searchController.value.text));
    }));
    // osscData.sort((a, b) => b.no!.compareTo(a.no!));
  }

  var isAppointment = ''.obs;
  setAppointment({required String dropdownDetail}) {
    isAppointment.value = dropdownDetail;
  }

  addAppointment(int index) async {
    // isAppointment.value == 'นัดตรวจ'?  : ;
    loading(true);
    await worksheet!.values
        .insertRow(
            index + 1,
            [
              isAppointment.value == 'ไม่มีการตรวจ' ? 'ไม่มี' : 'รอตรวจสถานที่',
              name.value,
              isAppointment.value == 'นัดตรวจ'
                  ? key.currentState?.fields['appDate']?.value.toString()
                  : isAppointment.value,
            ],
            fromColumn: 16)
        .then((value) => loadInformation());
    loading(false);
    Get.back();
    // print(key.currentState?.fields['appDate']?.value);
  }

  sendResult(int index) async {
    loading(true);
    if (fileNames.value != '') {
      // String nameReplace = fileNames.value.replaceAll(' ', '-');
      // listFile
      //     .map((file) async =>
      //         await upload2Ftp(pathFile: file.path, folderName: 'document'))
      //     .toList();
      for (var i = 0; i < listFileName.length; i++) {
        await upload2Onedrive(
            rawPath: listPickedFile!.files[i].bytes!,
            fileName: listPickedFile!.files[i].name);
      }
      await worksheet!.values
          .insertRow(
              index + 1,
              [
                fileNames.value == '' ? '-' : fileNames.value,
                resultStatus.value,
                TimeFormat().getDatetime(date: DateTime.now().toString()),
                name.value,
              ],
              fromColumn: 19)
          .then((value) => loadInformation());
      loading(false);
      Get.back();
    } // error alert
  }

  sendConsider(int index) async {
    loading(true);
    if (fileNames.value != '') {
      // String nameReplace = fileNames.value.replaceAll(' ', '-');
      // listFile
      //     .map((file) async =>
      //         await upload2Ftp(pathFile: file.path, folderName: 'document'))
      //     .toList();
      for (var i = 0; i < listFileName.length; i++) {
        await upload2Onedrive(
            rawPath: listPickedFile!.files[i].bytes!,
            fileName: listPickedFile!.files[i].name);
      }
      await worksheet!.values
          .insertRow(
              index + 1,
              [
                fileNames.value == '' ? '-' : fileNames.value,
                name.value,
              ],
              fromColumn: 23)
          .then((value) => loadInformation());
      loading(false);
      Get.back();
    } // error alert
  }

  acceptConsider(int index) async {
    loading(true);
    if (fileNames.value != '') {
      // String nameReplace = fileNames.value.replaceAll(' ', '-');
      // listFile
      //     .map((file) async =>
      //         await upload2Ftp(pathFile: file.path, folderName: 'document'))
      //     .toList();
      for (var i = 0; i < listFileName.length; i++) {
        await upload2Onedrive(
            rawPath: listPickedFile!.files[i].bytes!,
            fileName: listPickedFile!.files[i].name);
      }
      await worksheet!.values
          .insertRow(
              index + 1,
              [
                fileNames.value == '' ? '-' : fileNames.value,
                name.value,
              ],
              fromColumn: 25)
          .then((value) => loadInformation());
      loading(false);
      Get.back();
    } // error alert
  }

  addLicenseNumber(int index) async {
    loading(true);
    await worksheet!.values
        .insertRow(
            index + 1,
            [
              key.currentState?.fields['placeNumber']?.value,
              key.currentState?.fields['licenseNumber']?.value,
              key.currentState?.fields['businessNumber']?.value,
              key.currentState?.fields['operatingNumber']?.value,
              key.currentState?.fields['advertisingNumber']?.value,
              key.currentState?.fields['spaOperatorNumber']?.value,
            ],
            fromColumn: 27)
        .then((value) => loadInformation());
    loading(false);
    Get.back();
    // error alert
  }

  receiveDocuments(int index) async {
    loading(true);
    if (signature.isNotEmpty) {
      await upload2Onedrive(
          rawPath: signatureImage.value,
          fileName:
              '${osscFilterData[index - 1].customer}-${osscFilterData[index - 1].company}-signature.png');
    }
    await worksheet!.values
        .insertRow(
            index + 1,
            [
              sign.value,
              TimeFormat().getDatetime(
                  date: '${key.currentState?.fields['receiveDate']?.value}'),
              key.currentState?.fields['parcelNumber']?.value ?? '',
              signature.isNotEmpty
                  ? '${osscFilterData[index - 1].customer}-${osscFilterData[index - 1].company}-signature.png'
                  : ''
            ],
            fromColumn: 33)
        .then((value) async {
      if (sign.value != 'จัดส่งไปรษณีย์' ||
          key.currentState?.fields['parcelNumber']?.value != '') {
        await updateSuccessStatus(index);
      }
      loadInformation();
    });
    // signatureImage.value.clear();
    loading(false);
    Get.back();
    // error alert
  }

  updateSuccessStatus(int index) async {
    await worksheet!.values
        .insertRow(index + 1, ['เสร็จสิ้น'], fromColumn: 37)
        .then((value) => loadInformation());
    Get.back();
  }

  upload2Onedrive(
      {required Uint8List rawPath, required String fileName}) async {
    await Api()
        .reNewAccrssToken(refreshToken: GetStorage().read('refreshToken'))
        .then((value) async {
      // GetStorage().write('accessToken', value);
      //ANCHOR -  update refreshtoke in sheet

      token(value);
      update();
      log(token.value);
      final res = await Api()
          .uploadFile(file: rawPath, fileName: fileName, token: value);
      print(res);
    });
  }

  // removeMockFile(String strfilename) {
  //   // print(strfilename);
  //   if (mocked.value) {
  //     for (var file in strfilename.split(',-')) {
  //       File('assets/doc/$file').delete().ignore();
  //       print('remove : $file');
  //     }
  //   }
  //   mocked(false);
  // }

  List<District>? district;
  var isLongDistrict = false.obs;
  List<String> districtList = [];
  var districteSelected = ''.obs;

  Future<void> getDistrict() async {
    // isLongDistrict.value = true;
    await Api().getDistrict().then((value) {
      district = value;
    });
    var dis = district?.where((element) => element.provinceId == 28);
    // setValueDistrict();
    // isLongDistrict.value = false;
    dis?.forEach((element) {
      districtList.add(element.nameTh ?? '');
    });
  }

  var selectDistrict = ''.obs;
  setDistrict({required String dropdownDetail}) {
    selectDistrict.value = dropdownDetail;
  }
}

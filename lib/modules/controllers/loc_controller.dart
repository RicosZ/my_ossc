import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:get_storage/get_storage.dart';
import 'package:my_ossc/api/new_api.dart';
import 'package:signature/signature.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:universal_io/io.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../api/api.dart';
import '../../api/services/time_format.dart';
import '../../constants/credentials.dart';
import '../../models/district_model.dart';
import '../../models/new_ossc_data_model.dart';

// const _clientId = "1005734918784-qj24e6gjq99omrv7kf33um3k3plid0om.apps.googleusercontent.com";
// const _scopes = ['https://www.googleapis.com/auth/drive.file'];

class LocController extends GetxController {
  var name = 'กิตติชัย'.obs;
  // var osscData = <OsscData>[].obs;
  // var osscFilterData = <OsscData>[].obs;
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
    'อำเภอตรวจ(ส่ง KPBook แล้ว)',
    'ไม่มีการตรวจ',
  ];
  final List<String> listDocStatus = [
    'อยู่ระหว่างการตรวจสอบ',
    'ตรวจสอบเอกสารเสร็จสิ้น',
    'ส่งต่องานพรบ.พิจารณา',
    'คืนคำขอ'
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
    'ยื่นขอใบอนุญาตฯ ออนไลน์',
    'ยื่นต่ออายุใบอนุญาตฯ',
    'ยื่นต่ออายุใบอนุญาตฯ ออนไลน์',
    'ยื่นยกเลิกใบอนุญาตฯ',
    'ยื่นยกเลิกใบอนุญาตฯ ออนไลน์',
    'ยื่นแก้ไข/เปลี่ยนแปลง/ ใบแทน ใบอนุญาตฯ',
    'ยื่นแก้ไข/เปลี่ยนแปลง/ ใบแทน ใบอนุญาตฯ ออนไลน์',
    'เปลี่ยนผู้ดำเนินการ/ผู้มีหน้าที่ปฏิบัติการ',
    'เปลี่ยนผู้ดำเนินการ/ผู้มีหน้าที่ปฏิบัติการ ออนไลน์',
    'แจ้งเลิกผู้ดำเนินการ/ผู้มีหน้าที่ปฏิบัติการ',
    'แจ้งเลิกผู้ดำเนินการ/ผู้มีหน้าที่ปฏิบัติการ ออนไลน์',
    'ยื่นขออนุญาตโฆษณาฯ',
    'รับเอกสาร/ใบอนุญาตฯ',
    'เปิดสิทธิ์',
    'ติดต่อ สอบถาม',
    'อื่นๆ'
  ];
  final List<String> listFilterDesc = [
    'ทั้งหมด',
    'ยื่นขอใบอนุญาตฯ',
    'ยื่นขอใบอนุญาตฯ ออนไลน์',
    'ยื่นต่ออายุใบอนุญาตฯ',
    'ยื่นต่ออายุใบอนุญาตฯ ออนไลน์',
    'ยื่นยกเลิกใบอนุญาตฯ',
    'ยื่นยกเลิกใบอนุญาตฯ ออนไลน์',
    'ยื่นแก้ไข/เปลี่ยนแปลง/ ใบแทน ใบอนุญาตฯ',
    'ยื่นแก้ไข/เปลี่ยนแปลง/ ใบแทน ใบอนุญาตฯ ออนไลน์',
    'เปลี่ยนผู้ดำเนินการ/ผู้มีหน้าที่ปฏิบัติการ',
    'เปลี่ยนผู้ดำเนินการ/ผู้มีหน้าที่ปฏิบัติการ ออนไลน์',
    'แจ้งเลิกผู้ดำเนินการ/ผู้มีหน้าที่ปฏิบัติการ',
    'แจ้งเลิกผู้ดำเนินการ/ผู้มีหน้าที่ปฏิบัติการ ออนไลน์',
    'ยื่นขออนุญาตโฆษณาฯ',
    'รับเอกสาร/ใบอนุญาตฯ',
    'เปิดสิทธิ์',
    'ติดต่อ สอบถาม',
    'อื่นๆ'
  ];
  final List<String> listresultStatus = [
    'ผ่าน',
    'ไม่ผ่าน',
  ];
  final List<String> listReciveDoc = [
    'มารับเอง',
    'รับแทน',
    'เจ้าหน้าที่รับเอกสาร',
    'จัดส่งไปรษณีย์',
    'เปิดสิทธิ์แล้ว'
  ];
  final List<String> listReciveResultDoc = [
    'มารับเอง',
    'รับแทน',
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
    'สถานะเอกสาร',
    'ทีมตรวจรับเอกสาร',
    'วันที่รับ',
    "สถานะการตรวจสถานที่",
    "ตรวจสถานที่",
    "ผลตรวจ",
    "สถานะการตรวจ",
    "ส่งผลตรวจ",
    "เจ้าหน้าที่ส่งผลตรวจ",
    "การรับเอกสาร",
    "วันที่รับ",
    "ชื่อผู้รับ",
    "ลายเซ็นผู้รับ",
    "ใบอนุญาต/เอกสาร",
    "วันที่",
    "ค่าธรรมเนียม",
    "หลักฐานการชำระ",
    "เลขสถานที่",
    "เลขใบอนุญาต",
    "เลขใบอนุญาตประกอบกิจ",
    "เลขใบอนุญาตดำเนินการ",
    "เลขใบอนุญาตโฆษณา",
    "เลขใบอนุญาตผู้ดำเนินการสปา",
    "รับใบอนุญาต/รับเอกสาร",
    "วันที่รับ/วันที่จัดส่ง",
    "ชื่อผู้รับ/เลขพัสดุ",
    "ลายเซ็นต์",
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

  var newOssc = <OsscDataNew>[].obs;
  // var osscFilterData = <OsscData>[].obs;
  getInformation() async {
    isLoading(true);
    // final da = await Api().fetchDataAll();
    final res = await NewApi().getInformation(
      act: act.value == 'ทั้งหมด' ? '' : act.value,
      desc: desc.value == 'ทั้งหมด' ? '' : desc.value,
      search: searchController.value.text,
    );
    print(res);
    newOssc.assignAll(res.data ?? []);
    // osscData.assignAll(da.data ?? []);
    // osscFilterData.assignAll(da.data ?? []);
    isLoading(false);
  }

  loadInformation() async {
    // final da = await Api().fetchDataAll();
    // osscData.assignAll(da.data ?? []);
    // osscFilterData.assignAll(da.data ?? []);
    final res = await NewApi().getInformation(
      act: act.value == 'ทั้งหมด' ? '' : act.value,
      desc: desc.value == 'ทั้งหมด' ? '' : desc.value,
      search: searchController.value.text,
    );
    newOssc.assignAll(res.data ?? []);
    // osscData.sort((a, b) => b.no!.compareTo(a.no!));
  }

  var act = ''.obs;
  var fillact = ''.obs;
  var result = ''.obs;
  setAct({required String dropdownDetail, required bool added}) {
    added ? fillact.value = dropdownDetail : act.value = dropdownDetail;
  }

  var desc = ''.obs;
  var filldesc = ''.obs;
  setDesc({required String dropdownDetail, required bool added}) {
    added ? filldesc.value = dropdownDetail : desc.value = dropdownDetail;
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
    try {
      await NewApi()
          .addInformation(
            date: key.currentState?.fields['date']?.value.toString(),
            customer: key.currentState?.fields['name']?.value,
            company: key.currentState?.fields['company']?.value,
            district: selectDistrict.value == 'อื่นๆ'
                ? key.currentState?.fields['customDistrict']?.value
                : selectDistrict.value,
            tel: key.currentState?.fields['phone']?.value.toString(),
            act: fillact.value,
            type: key.currentState?.fields['loaclType']?.value,
            desc: filldesc.value == 'อื่นๆ'
                ? key.currentState?.fields['customDesc']?.value
                : filldesc.value,
            cost: key.currentState?.fields['cost']?.value,
            slipUrl: imgName.value == '' ? '-' : imgName.value,
            doc: fileNames.value == '' ? '-' : fileNames.value,
            requestStaff: name.value,
          )
          .then((value) async => {
                if (imgName.value != '')
                  {
                    await upload2Onedrive(
                        rawPath: listPickedImage!.files.first.bytes!,
                        fileName: listPickedImage!.files.first.name,
                        act: 'slip',
                        dir: '',
                        des: '')
                  },
                if (fileNames.value != '')
                  {
                    for (var i = 0; i < listFileName.length; i++)
                      {
                        await upload2Onedrive(
                            rawPath: listPickedFile!.files[i].bytes!,
                            fileName: listPickedFile!.files[i].name,
                            act: fillact.value,
                            dir: '/เอกสารคำขอ',
                            des:
                                '/${value['receiveNumber'].split('/')[1]}/${filldesc.value == 'อื่นๆ' ? key.currentState?.fields['customDesc']?.value.replaceAll('/', ' ') : filldesc.value.replaceAll('/', ' ')}/${value['receiveNumber'].toString().replaceAll('/', '-')}'),
                      }
                  },
                print(value['receiveNumber']),
                loadInformation(),
              }); //loading new data
    } catch (e) {
      print(e);
    }
    imgUrl('');
    loading(false);
    Get.back();
  }

  editInformation(String receiveNumber, int index) async {
    loading(true);
    if (imgName.value != '') {
      await upload2Onedrive(
          rawPath: listPickedImage!.files.first.bytes!,
          fileName: listPickedImage!.files.first.name,
          act: 'slip',
          dir: '',
          des: '');
    }
    if (fileNames.value != '') {
      for (var i = 0; i < listFileName.length; i++) {
        await upload2Onedrive(
          rawPath: listPickedFile!.files[i].bytes!,
          fileName: listPickedFile!.files[i].name,
          act: fillact.value == '' ? newOssc[index].act! : fillact.value,
          dir: '/เอกสารคำขอ',
          des:
              '/${receiveNumber.split('/')[1]}/${filldesc.value == '' ? newOssc[index].desc?.replaceAll('/', ' ') : filldesc.value == 'อื่นๆ' ? key.currentState?.fields['customDesc']?.value.replaceAll('/', ' ') : filldesc.value.replaceAll('/', ' ')}/${receiveNumber.replaceAll('/', '-')}',
        );
      }
    }
    await NewApi().editInformation(data: {
      'receiveNumber': receiveNumber,
      'customer': key.currentState?.fields['name']?.value,
      'company': key.currentState?.fields['company']?.value,
      'district': selectDistrict.value == ''
          ? newOssc[index].district
          : selectDistrict.value == 'อื่นๆ'
              ? key.currentState?.fields['customDistrict']?.value
              : selectDistrict.value,
      'tel': key.currentState?.fields['phone']?.value.toString(),
      'act': fillact.value == '' ? newOssc[index].act : fillact.value,
      'type': key.currentState?.fields['loaclType']?.value,
      'desc': filldesc.value == ''
          ? newOssc[index].desc
          : filldesc.value == 'อื่นๆ'
              ? key.currentState?.fields['customDesc']?.value
              : filldesc.value,
      'cost': key.currentState?.fields['cost']?.value,
      'slipUrl': imgName.value == '' ? newOssc[index].slipUrl : imgName.value,
      'doc': fileNames.value == '' ? newOssc[index].doc : fileNames.value,
    }).then((value) => loadInformation());
    imgUrl('');
    loading(false);
    Get.back();
  }

  var imgName = ''.obs;
  File? image;
  var imgUrl = ''.obs;
  var isPickedImage = false.obs;
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
      isPickedImage(true);
      isPickedImage.refresh();
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
  RxBool ready2Download = false.obs;

  getRequireInformation({
    required String folder,
    required String fileName,
    required String act,
    required String dir,
    required String des,
    required bool isFile,
  }) async {
    pdfloading(true);
    ready2Download(false);
    // filePath('$folder/${listPath[act]}$dir$des/$fileName');
    filePath('/04_Premarketing/file_upload/$fileName');
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

        await Api().fetchFile(
            refreshToken: value, path2File: filePath.value, isFile: isFile);
        update();
        // log(token.value);
      });
      filePath.value.split('.').last != 'pdf'
          ? ready2Download(true)
          : ready2Download(false);
      pdfloading(false);
      // }
      // print(GetStorage().read('accessToken'));
      // return fileName;
    } catch (e) {
      // print(e);
    }
  }

  searchInformation() async {
    isLoading(true);
    final res = await NewApi().getInformation(
      act: act.value == 'ทั้งหมด' ? '' : act.value,
      desc: desc.value == 'ทั้งหมด' ? '' : desc.value,
      search: searchController.value.text,
      limit: (act.value == 'ทั้งหมด' || act.value == '') &&
              (desc.value == 'ทั้งหมด' || desc.value == '')
          ? 100
          : 0,
    );
    newOssc.assignAll(res.data ?? []);
    isLoading(false);
  }

  var docStatus = ''.obs;
  setDocStatus({required String dropdownDetail}) {
    docStatus.value = dropdownDetail;
  }

  updateDoStatus(String receiveNumber) async {
    loading(true);
    await NewApi().editInformation(data: {
      'receiveNumber': receiveNumber,
      'docStatus': docStatus.value,
    }).then((value) => loadInformation());
    loading(false);
    Get.back();
  }

  var isAppointment = ''.obs;
  setAppointment({required String dropdownDetail}) {
    isAppointment.value = dropdownDetail;
  }

  receive(String receiveNumber) async {
    // isAppointment.value == 'นัดตรวจ'?  : ;
    loading(true);
    await NewApi().editInformation(data: {
      'receiveNumber': receiveNumber,
      'inspectionTeam': name.value,
      'recivedDate': TimeFormat().getDatetime(date: DateTime.now().toString()),
    }).then((value) => loadInformation());
    loading(false);
    Get.back();
    // print(key.currentState?.fields['appDate']?.value);
  }

  addAppointment(String receiveNumber) async {
    // isAppointment.value == 'นัดตรวจ'?  : ;
    loading(true);
    await NewApi().editInformation(data: {
      'receiveNumber': receiveNumber,
      'waitingToCheck':
          isAppointment.value == 'ไม่มีการตรวจ' ? 'ไม่มี' : 'รอตรวจสถานที่',
      'checkLocation': isAppointment.value == 'นัดตรวจ'
          ? key.currentState?.fields['appDate']?.value.toString()
          : '${isAppointment.value} ${TimeFormat().getDateTime(date: key.currentState?.fields['appDate']?.value.toString())}',
    }).then((value) => loadInformation());
    // await worksheet!.values
    //     .insertRow(
    //         index + 1,
    //         [
    //           isAppointment.value == 'ไม่มีการตรวจ' ? 'ไม่มี' : 'รอตรวจสถานที่',
    //           isAppointment.value == 'นัดตรวจ'
    //               ? key.currentState?.fields['appDate']?.value.toString()
    //               : '${isAppointment.value} ${TimeFormat().getDateTime(date: key.currentState?.fields['appDate']?.value.toString())}',
    //         ],
    //         fromColumn: 19)
    //     .then((value) => loadInformation());
    loading(false);
    Get.back();
    // print(key.currentState?.fields['appDate']?.value);
  }

  sendResult(String receiveNumber, String act, String des) async {
    loading(true);
    if (fileNames.value != '') {
      for (var i = 0; i < listFileName.length; i++) {
        await upload2Onedrive(
            rawPath: listPickedFile!.files[i].bytes!,
            fileName: listPickedFile!.files[i].name,
            act: act,
            dir: '/เอกสารผลตรวจ',
            des:
                '/${receiveNumber.split('/')[1]}/${receiveNumber.replaceAll('/', '-')}');
      }
      await NewApi().editInformation(data: {
        'receiveNumber': receiveNumber,
        'results': fileNames.value == '' ? '-' : fileNames.value,
        'sendResults': resultStatus.value,
        'resultsStatus':
            TimeFormat().getDatetime(date: DateTime.now().toString()),
        'officer2': name.value,
      }).then((value) => loadInformation());
      loading(false);
      Get.back();
    } // error alert
  }

  reciveResultDco(String receiveNumber, String act) async {
    loading(true);
    if (signature.isNotEmpty) {
      await upload2Onedrive(
        rawPath: signatureImage.value,
        fileName:
            '${key.currentState?.fields['recivedName']?.value}-result-signature.png',
        act: act,
        dir: '/signature',
        des: '/${receiveNumber.replaceAll('/', '-')}',
      );
    }
    await NewApi().editInformation(data: {
      'receiveNumber': receiveNumber,
      'recived': sign.value,
      'recivedResultDate': TimeFormat().getDatetime(
          date: '${key.currentState?.fields['receiveDate']?.value}'),
      'recivedName': key.currentState?.fields['recivedName']?.value ?? '',
      'recivedSign': signature.isNotEmpty
          ? '${key.currentState?.fields['recivedName']?.value}-result-signature.png'
          : ''
    }).then((value) => loadInformation());
    loading(false);
    Get.back();
  }

  addLicense(String receiveNumber, String act, String des) async {
    loading(true);
    if (fileNames.value != '') {
      for (var i = 0; i < listFileName.length; i++) {
        await upload2Onedrive(
            rawPath: listPickedFile!.files[i].bytes!,
            fileName: listPickedFile!.files[i].name,
            act: act,
            dir: '/ใบอนุญาต',
            des:
                '/${receiveNumber.split('/')[1]}/${receiveNumber.replaceAll('/', '-')}');
      }
      await NewApi().editInformation(data: {
        'receiveNumber': receiveNumber,
        'license': fileNames.value == '' ? '-' : fileNames.value,
        'licenseDate':
            TimeFormat().getDatetime(date: DateTime.now().toString()),
      }).then((value) => loadInformation());
      loading(false);
      Get.back();
    } // error alert
  }

  addLicenseFee(String receiveNumber) async {
    loading(true);
    if (imgName.value != '') {
      await upload2Onedrive(
        rawPath: listPickedImage!.files.first.bytes!,
        fileName: listPickedImage!.files.first.name,
        act: 'slip',
        dir: '',
        des: '',
      );
    }
    await NewApi().editInformation(data: {
      'receiveNumber': receiveNumber,
      'licenseFee': key.currentState?.fields['licenseFee']?.value,
      'licenseFeeSlip': imgName.value == '' ? '-' : imgName.value,
    }).then((value) => loadInformation());
    loading(false);
    Get.back();
  }

  addLicenseNumber(String receiveNumber) async {
    loading(true);
    await NewApi().editInformation(data: {
      'receiveNumber': receiveNumber,
      'placeNumber': key.currentState?.fields['placeNumber']?.value,
      'licenseNumber': key.currentState?.fields['licenseNumber']?.value,
      'businessLicenseNumber':
          key.currentState?.fields['businessNumber']?.value,
      'operationLicenseNumber':
          key.currentState?.fields['operatingNumber']?.value,
      'advertisingLicenseNumber':
          key.currentState?.fields['advertisingNumber']?.value,
      'spaOperatorLicenseNumber':
          key.currentState?.fields['spaOperatorNumber']?.value,
    }).then((value) => loadInformation());
    loading(false);
    Get.back();
    // error alert
  }

  receiveDocuments(String receiveNumber, int index, String act) async {
    loading(true);
    if (signature.isNotEmpty) {
      print('uploading----------');
      await upload2Onedrive(
        rawPath: signatureImage.value,
        fileName:
            '${key.currentState?.fields['parcelNumber']?.value}-signature.png',
        act: act,
        dir: '/signature',
        des: '/${receiveNumber.replaceAll('/', '-')}',
      );
    }
    await NewApi().editInformation(data: {
      'receiveNumber': receiveNumber,
      'sign': sign.value,
      'receiveDate': TimeFormat().getDatetime(
          date: '${key.currentState?.fields['receiveDate']?.value}'),
      'parcelNumber': key.currentState?.fields['parcelNumber']?.value ?? '',
      'signature': signature.isNotEmpty
          ? '${key.currentState?.fields['parcelNumber']?.value}-signature.png'
          : ''
    }).then((value) => loadInformation());
    // await worksheet!.values
    //     .insertRow(
    //         index + 1,
    //         [
    //           sign.value,
    //           TimeFormat().getDatetime(
    //               date: '${key.currentState?.fields['receiveDate']?.value}'),
    //           key.currentState?.fields['parcelNumber']?.value ?? '',
    //           signature.isNotEmpty
    //               ? '${key.currentState?.fields['parcelNumber']?.value}-${osscFilterData[index - 1].company}-signature.png'
    //               : ''
    //         ],
    //         fromColumn: 42)
    //     .then((value) async {
    if (sign.value != 'จัดส่งไปรษณีย์' ||
        key.currentState?.fields['parcelNumber']?.value != '') {
      await updateSuccessStatus(receiveNumber, index);
    }
    loadInformation();
    // });
    // signatureImage.value.clear();
    loading(false);
    Get.back();
    // error alert
  }

  updateSuccessStatus(String receiveNumber, int index) async {
    await NewApi().editInformation(data: {
      'receiveNumber': receiveNumber,
      'status': newOssc[index].docStatus == 'คืนคำขอ' ? 'คืนคำขอ' : 'เสร็จสิ้น',
    }).then((value) => loadInformation());
    // await worksheet!.values
    //     .insertRow(
    //         index + 1,
    //         [
    // osscFilterData[index - 1].docStatus == 'คืนคำขอ'
    //     ? 'คืนคำขอ'
    //     : 'เสร็จสิ้น'
    //         ],
    //         fromColumn: 46)
    //     .then((value) => loadInformation());
    Get.back();
  }

  Map<String, String> listPath = {
    'ยา': '0402_ยา',
    'อาหาร': '0401_อาหาร',
    'สถานพยาบาล': '0408_สถานพยาบาล',
    'เครื่องมือแพทย์': '0406_เครื่องมือแพทย์',
    'ผลิตภัณฑ์สมุนไพร': '0404_ผลิตภัณฑ์สมุนไพร',
    'วัตถุออกฤทธิต่อจิตและประสาท': '0405_ยสวจ',
    'เครื่องสำอาง': '0403_เครื่องสำอาง',
    'กัญชง/กัญชาทางการแพทย์': 'file_upload',
    'วัตถุอันตราย': '0407_วัตถุอันตราย',
    'ยาเสพติด': '0405_ยสวจ',
    'สถานประกอบการเพื่อสุขภาพ': '0409_สถานประกอบการเพื่อสุขภาพ',
    'slip': 'file_upload',
  };

  upload2Onedrive({
    required Uint8List rawPath,
    required String fileName,
    required String act,
    required String dir,
    required String des,
  }) async {
    await Api()
        .reNewAccrssToken(refreshToken: GetStorage().read('refreshToken'))
        .then((value) async {
      // GetStorage().write('accessToken', value);
      //ANCHOR -  update refreshtoke in sheet

      token(value);
      update();
      log(token.value);
      final res = await Api().uploadFile(
          file: rawPath,
          fileName: fileName,
          token: value,
          // directory: '04_Premarketing/${listPath[act]}$dir$des');
          directory: '04_Premarketing/file_upload');
      print(res);
    });
  }

  removeTempFile(String fileName) async {
    print(fileName);
    await NewApi().removeTempFile(fileName: fileName);
  }

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
    districtList.add('อื่นๆ');
  }

  var selectDistrict = ''.obs;
  setDistrict({required String dropdownDetail}) {
    selectDistrict.value = dropdownDetail;
  }

  exportDate({
    required String act,
    required String desc,
  }) async {
    loading(true);
    try {
      await NewApi()
          .exportDate(
        act: act == 'ทั้งหมด' ? '' : act,
        desc: desc == 'ทั้งหมด' ? '' : desc,
        dateBefor: '${key.currentState?.fields['dateBefor']?.value}',
        dateAfter: '${key.currentState?.fields['dateAfter']?.value}',
        // dateBefor: '2024-03-20T17:00:00.000+00:00',
        // dateAfter: '2024-03-25T17:00:00.000+00:00',
      )
          .then((value) {
        if (value['success']) {
          launchUrlString(
            'https://ossc-api.onrender.com/download/ossc-data.xlsx',
          );
        }
      });
      loading(false);
    } catch (e) {
      print(e);
    }
  }
}

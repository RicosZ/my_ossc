import 'dart:developer';
// import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ossc/modules/controllers/loc_controller.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../constants/colors.dart';
import '../../constants/notosansthai.dart';

class FilePopUp {
  LocController controller = Get.find();
  image(
          {required String filePath,
          required String token,
          required String label}) =>
      Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Container(
          height: 600,
          width: 520,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: NotoSansThai.h1.copyWith(color: Palette.black),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: 480,
                    width: 520,
                    padding: const EdgeInsets.all(8),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    // child: Image.memory(
                    //   controller.pdfFileUrl.value,
                    //   height: 480,
                    // ),
                    child: Image.network(
                      'https://graph.microsoft.com/v1.0/me/drive/root:$filePath:/content',
                      headers: {'Authorization': 'Bearer $token'},
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'ปิด',
                    style: NotoSansThai.normal.copyWith(color: Palette.white),
                  ))
            ],
          ),
        ),
      )).then((value) {
        // controller.removeMockFile(imgUrl);
        controller.pdfFileUrl.value = Uint8List(0);
      });

  document(
          {required String fileName,
          required String act,
          required String dir,
          required String des}) async =>
      Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Container(
          height: 800,
          width: 800,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Align(
              //   alignment: Alignment.topRight,
              //   child: ElevatedButton(
              //       onPressed: () async {
              //         controller.ready2Download.value
              //             ? controller.removeTempFile(fileName)
              //             : null;
              //         Get.back();
              //       },
              //       child: Text(
              //         'ปิด',
              //         style: NotoSansThai.normal.copyWith(color: Palette.white),
              //       )),
              // ),
              Text(
                'เอกสารคำขอ',
                style: NotoSansThai.h1.copyWith(color: Palette.black),
              ),
              Expanded(
                // height: 768,
                // width: 768,
                child: Row(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (var file in fileName.split(', '))
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () async {
                                    controller.open(true);
                                    controller.pdfloading(true);
                                    // controller.pdfFileUrl.value =
                                    await controller.getRequireInformation(
                                        isFile: true,
                                        folder: '/04_Premarketing',
                                        act: act,
                                        dir: dir,
                                        des: des,
                                        fileName: file);
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              width: 1, color: Palette.storke)),
                                      width: 200,
                                      child: Text(
                                        file,
                                        // overflow: TextOverflow.clip,
                                        // maxLines: 2,
                                      ))),
                            ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                              height: 740,
                              width: 520,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Obx(
                                () => controller.open.value
                                    ? controller.pdfloading.value
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : controller.filePath.value
                                                    .split('.')
                                                    .last ==
                                                'pdf'
                                            ? pdfView(
                                                filePath:
                                                    controller.filePath.value,
                                                token: controller.token.value)
                                            : SingleChildScrollView(
                                                child: Container(
                                                  // height: 480,
                                                  // width: 520,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  // child: Image.memory(
                                                  //   controller.pdfFileUrl.value,
                                                  //   height: 480,
                                                  // ),
                                                  child: Image.network(
                                                    'https://graph.microsoft.com/v1.0/me/drive/root:${controller.filePath.value}:/content',
                                                    headers: {
                                                      'Authorization':
                                                          'Bearer ${controller.token.value}'
                                                    },
                                                  ),
                                                ),
                                              )
                                    : Container(),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Obx(() => ElevatedButton(
                  onPressed: controller.ready2Download.value
                      ? () {
                          launchUrlString(
                            'https://my-ossc-be.vercel.app/download/$fileName',
                          );
                          // Get.back();
                        }
                      : null,
                  child: Text(
                    'ดาวน์โหลด',
                    style: NotoSansThai.normal.copyWith(color: Palette.white),
                  )))
            ],
          ),
        ),
      )).then((value) {
        controller.removeTempFile(fileName);
        controller.pdfFileUrl.value = Uint8List(0);
        controller.open(false);
        controller.pdfloading(true);
        controller.ready2Download(false);
      });
  // pdfView({required String fileUrl}) => SfPdfViewer.network(
  //       fileUrl, key: controller.pdfViewerKey,
  //       // height: 480,
  //     );
  pdfView({required String filePath, required String token}) =>
      SfPdfViewer.network(
        controller: controller.pdfViewerController,
        onDocumentLoaded: (details) {
          controller.ready2Download(true);
        },
        onDocumentLoadFailed: (details) {
          inspect(details);
        },
        'https://graph.microsoft.com/v1.0/me/drive/root:$filePath:/content',
        headers: {'Authorization': 'Bearer $token'},
        key: controller.pdfViewerKey,
        // height: 480,
      );
  // pdfView({required Uint8List fileUrl}) => SfPdfViewer.memory(
  //         // enableTextMarkupAnnotation: true,
  //         controller: controller.pdfViewerController,
  //         onDocumentLoadFailed: (details) {
  //       inspect(details);
  //     }, fileUrl,
  //         key: controller.pdfViewerKey,
  //         // height: 480,
  //         );
}

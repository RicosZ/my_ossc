import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../constants/colors.dart';
import '../../constants/notosansthai.dart';
import '../controllers/list_of_content_controller.dart';

class FilePopUp {
  ListOfContentController controller = Get.find();
  image({required String imgUrl}) => Get.dialog(Dialog(
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
                'การชำระค่าธรรมเนียม',
                style: NotoSansThai.h1.copyWith(color: Palette.black),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                      height: 480,
                      width: 520,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: Image.memory(
                        controller.pdfFileUrl.value,
                        height: 480,
                      )),
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
        controller.removeMockFile(imgUrl);
        controller.pdfFileUrl.value = Uint8List(0);
      });

  document({required String fileName}) async => Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Container(
          height: 800,
          width: 800,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'เอกสารคำขอ',
                style: NotoSansThai.h1.copyWith(color: Palette.black),
              ),
              Expanded(
                // height: 768,
                // width: 768,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (var file in fileName.split(',-'))
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: () async {
                                  controller.open(true);
                                  controller.pdfloading(true);
                                  // controller.pdfFileUrl.value =
                                  await controller.getFileUrl(
                                      folder: 'document', fileName: file);
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
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
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : pdfView(
                                            fileUrl:
                                                controller.pdfFileUrl.value)
                                    : Container(),
                              )),
                        ),
                      ],
                    ),
                  ],
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
        controller.removeMockFile(fileName);
        controller.pdfFileUrl.value = Uint8List(0);
        controller.open(false);
        controller.pdfloading(true);
      });
  // pdfView({required String fileUrl}) => SfPdfViewer.network(
  //       fileUrl, key: controller.pdfViewerKey,
  //       // height: 480,
  //     );
  // pdfView({required String fileUrl}) => SfPdfViewer.asset(
  //       onDocumentLoadFailed: (details) {
  //         inspect(details);
  //       },
  //       fileUrl, key: controller.pdfViewerKey,
  //       // height: 480,
  //     );
  pdfView({required Uint8List fileUrl}) => SfPdfViewer.memory(
          // enableTextMarkupAnnotation: true,
          controller: controller.pdfViewerController,
          onDocumentLoadFailed: (details) {
        inspect(details);
      }, fileUrl,
          key: controller.pdfViewerKey,
          // height: 480,
          );
}

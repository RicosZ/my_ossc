import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:my_ossc/modules/widgets/edit_information.dart';

import '../../constants/colors.dart';
import '../../constants/notosansthai.dart';
import '../controllers/list_of_content_controller.dart';

class Menu {
  ListOfContentController controller = Get.find();
  list(int index, String company, BuildContext context) => Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Container(
            height: 480,
            width: 520,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 32,
                ),
                Text(
                  company,
                  style: NotoSansThai.h1,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    ListOfContentPopup().edit(context, index);
                  },
                  child: customContainer('แก้ไขข้อมูล'),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    appointment(index);
                  },
                  child: customContainer('นัดตรวจสถานที่'),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    appointResult(index);
                  },
                  child: customContainer('ส่งผลตรวจสถานที่'),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    consider(index);
                  },
                  child: customContainer('อัพโหลดใบอนุญาต'),
                ),
                const SizedBox(height: 16),
                // InkWell(
                //   onTap: () {
                //     accept(index);
                //   },
                //   child: customContainer('อนุมัติ'),
                // ),
                // const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    addLicense(index);
                  },
                  child: customContainer('เพิ่มข้อมูลการอนุญาต'),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    controller
                        .sign(controller.osscData[index - 1].sign.toString());
                    receiveDocuments(index);
                  },
                  child: customContainer('รับเอกสาร/เพิ่มเลขพัสดุ'),
                ),
                const Spacer()
              ],
            )),
      ));
  //ANCHOR -  นัดตรวจ
  appointment(int index) => Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Obx(() => Container(
            height: 300,
            width: 520,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: FormBuilder(
              key: controller.key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('นัดตรวจสถานที่ ${controller.osscData[index-1].company}',
                      style: NotoSansThai.h1.copyWith(color: Palette.black)),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('การตรวจสถานที่: ',
                            style:
                                NotoSansThai.h3.copyWith(color: Palette.black)),
                      ),
                      SizedBox(
                        width: 240,
                        child: FormBuilderDropdown(
                            borderRadius: BorderRadius.circular(16),
                            onChanged: (value) {
                              controller.setAppointment(dropdownDetail: value!);
                            },
                            name: 'appointStatus',
                            decoration: customAppInputDecoration(
                                hintText: 'เลือกรายการ'),
                            isExpanded: true,
                            items: controller.listAppointment
                                .map(
                                  (option) => DropdownMenuItem(
                                    value: option,
                                    child: Text(
                                      option,
                                      style: NotoSansThai.normal
                                          .copyWith(color: Palette.black),
                                    ),
                                  ),
                                )
                                .toList()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(),
                  // const SizedBox(height: 16),/
                  controller.isAppointment.value == 'นัดตรวจ'
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('วันที่นัดหมาย: ',
                                  style: NotoSansThai.h3
                                      .copyWith(color: Palette.black)),
                            ),
                            SizedBox(
                              width: 200,
                              child: FormBuilderDateTimePicker(
                                name: 'appDate',
                                onChanged: (value) {
                                  controller
                                      .key.currentState?.fields['appDate']!
                                      .save();
                                  // controller.date.value = value!;
                                },
                              ),
                            ),
                          ],
                        )
                      : controller.isAppointment.value == ''
                          ? Container(
                              alignment: Alignment.centerLeft,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Text(
                                '*กรุณาเลือกรายการ!!!',
                                style: NotoSansThai.normal
                                    .copyWith(color: Palette.red),
                              ),
                            )
                          : Container(),
                  const SizedBox(height: 16),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        onPressed: () {
                          controller.isAppointment.value != ''
                              ? controller.addAppointment(index)
                              : null;
                        },
                        child: Text(
                          'บันทึก',
                          style: NotoSansThai.normal
                              .copyWith(color: Palette.black),
                        )),
                  )
                ],
              ),
            ))),
      )).then((value) => controller.isAppointment.value = '');
  //ANCHOR -  ส่งผลตรวจสถานที่
  appointResult(int index) => Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Obx(() => Container(
            height: 610,
            width: 520,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('ผลการตรวจตรวจสถานที่ ${controller.osscData[index-1].company}',
                    style: NotoSansThai.h1.copyWith(color: Palette.black)),
                const SizedBox(height: 16),
                Container(
                    width: 380,
                    height: 260,
                    decoration: BoxDecoration(
                        color: Palette.white,
                        border: Border.all(color: Palette.grey1),
                        borderRadius: BorderRadius.circular(16)),
                    child: ElevatedButton(
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 38,
                          ),
                          Text(
                            'อัพโหลดเอกสาร',
                            style: NotoSansThai.h1,
                          )
                        ],
                      ),
                      onPressed: () {
                        controller.pickFile();
                      },
                    )),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 48),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 160,
                      child: FormBuilderDropdown(
                          borderRadius: BorderRadius.circular(16),
                          onChanged: (value) {
                            controller.setResultStatus(dropdownDetail: value!);
                          },
                          validator: (value) {
                            if (value == null) {
                              return '';
                            }
                            return null;
                          },
                          name: 'resultStatus',
                          decoration:
                              customAppInputDecoration(hintText: 'เลือกรายการ'),
                          isExpanded: true,
                          items: controller.listresultStatus
                              .map(
                                (option) => DropdownMenuItem(
                                  value: option,
                                  child: Text(
                                    option,
                                    style: NotoSansThai.normal
                                        .copyWith(color: Palette.black),
                                  ),
                                ),
                              )
                              .toList()),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                controller.listFileName.isNotEmpty
                    //list file
                    ? SizedBox(
                        height: 129,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 52),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var file in controller.listFileName)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Palette.lightGrey,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Text(file)),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 52),
                        child: Text(
                          '*กรุณาอัพโหลดเอกสาร!!!',
                          style:
                              NotoSansThai.normal.copyWith(color: Palette.red),
                        ),
                      ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.listFileName.isNotEmpty
                            ? controller.sendResult(index)
                            : null;
                      },
                      child: Text(
                        'บันทึก',
                        style:
                            NotoSansThai.normal.copyWith(color: Palette.black),
                      )),
                )
              ],
            ))),
      )).then((value) => {
            controller.listFileName.value = [],
            controller.fileNames.value = ''
          });
  //ANCHOR -  อัพโหลดใบอนุญาต
  consider(int index) => Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Obx(() => Container(
            height: 600,
            width: 520,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('อัพโหลดใบอนุญาต ${controller.osscData[index-1].company}',
                    style: NotoSansThai.h1.copyWith(color: Palette.black)),
                const SizedBox(height: 16),
                Container(
                    width: 380,
                    height: 260,
                    decoration: BoxDecoration(
                        color: Palette.white,
                        border: Border.all(color: Palette.grey1),
                        borderRadius: BorderRadius.circular(16)),
                    child: ElevatedButton(
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 38,
                          ),
                          Text(
                            'อัพโหลดเอกสาร',
                            style: NotoSansThai.h1,
                          )
                        ],
                      ),
                      onPressed: () {
                        controller.pickFile();
                      },
                    )),
                const SizedBox(height: 16),
                controller.listFileName.isNotEmpty
                    //list file
                    ? SizedBox(
                        height: 180,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 52),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var file in controller.listFileName)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Palette.lightGrey,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Text(file)),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 52),
                        child: Text(
                          '*กรุณาอัพโหลดเอกสาร!!!',
                          style:
                              NotoSansThai.normal.copyWith(color: Palette.red),
                        ),
                      ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.listFileName.isNotEmpty
                            ? controller.sendConsider(index)
                            : null;
                      },
                      child: Text(
                        'บันทึก',
                        style:
                            NotoSansThai.normal.copyWith(color: Palette.black),
                      )),
                )
              ],
            ))),
      )).then((value) => {
            controller.listFileName.value = [],
            controller.fileNames.value = ''
          });
  // //ANCHOR -  อนุมัติ
  // accept(int index) => Get.dialog(
  //       Dialog(
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
  //         child: Container(
  //           height: 420,
  //           width: 520,
  //           padding: const EdgeInsets.all(16),
  //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               Text('อนุมัติ$index',
  //                   style: NotoSansThai.h1.copyWith(color: Palette.black)),
  //               const SizedBox(height: 16),
  //               //
  //               const SizedBox(height: 16),
  //               const Spacer(),
  //               Align(
  //                 alignment: Alignment.bottomRight,
  //                 child: ElevatedButton(
  //                     onPressed: () {},
  //                     child: Text(
  //                       'บันทึก',
  //                       style:
  //                           NotoSansThai.normal.copyWith(color: Palette.black),
  //                     )),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //ANCHOR -  เพิ่มเลขใบอนุญาต
  addLicense(int index) => Get.dialog(
        Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: Container(
            height: 520,
            width: 680,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: FormBuilder(
              key: controller.key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('เพิ่มข้อมูลการอนุญาต ${controller.osscData[index-1].company}',
                      style: NotoSansThai.h1.copyWith(color: Palette.black)),
                  const SizedBox(height: 16),
                  //
                  Row(
                    children: [
                      Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('เลขสถาที่', style: NotoSansThai.h2),
                              customFormTextField(
                                  key: 'placeNumber',
                                  decoration: customAppInputDecoration(
                                      hintText: 'เลขสถาที่'))
                            ],
                          )),
                      const SizedBox(width: 24),
                      Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('เลขใบอนุญาต', style: NotoSansThai.h2),
                              customFormTextField(
                                  key: 'licenseNumber',
                                  decoration: customAppInputDecoration(
                                      hintText: 'เลขใบอนุญาต'))
                            ],
                          ))
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('เลขใบอนุญาตประกอบกิจ',
                                  style: NotoSansThai.h2),
                              customFormTextField(
                                  key: 'businessNumber',
                                  decoration: customAppInputDecoration(
                                      hintText: 'เลขใบอนุญาตประกอบกิจ'))
                            ],
                          )),
                      const SizedBox(width: 24),
                      Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('เลขใบอนุญาตดำเนินการ',
                                  style: NotoSansThai.h2),
                              customFormTextField(
                                  key: 'operatingNumber',
                                  decoration: customAppInputDecoration(
                                      hintText: 'เลขใบอนุญาตดำเนินการ'))
                            ],
                          ))
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('เลขใบอนุญาตโฆษณา',
                                  style: NotoSansThai.h2),
                              customFormTextField(
                                  key: 'advertisingNumber',
                                  decoration: customAppInputDecoration(
                                      hintText: 'เลขใบอนุญาตโฆษณา'))
                            ],
                          )),
                      const SizedBox(width: 24),
                      Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('เลขใบอนุญาตผู้ดำเนินการสปา',
                                  style: NotoSansThai.h2),
                              customFormTextField(
                                  key: 'spaOperatorNumber',
                                  decoration: customAppInputDecoration(
                                      hintText: 'เลขใบอนุญาตผู้ดำเนินการสปา'))
                            ],
                          ))
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        onPressed: () {
                          if (controller.key.currentState!.saveAndValidate()) {
                            controller.addLicenseNumber(index);
                          }
                        },
                        child: Text(
                          'บันทึก',
                          style: NotoSansThai.normal
                              .copyWith(color: Palette.black),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  //ANCHOR -  รับเอกสาร
  receiveDocuments(int index) => Get.dialog(
        Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: Container(
            height: 420,
            width: 460,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Obx(() => FormBuilder(
                  key: controller.key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('รับเอกสาร/เพิ่มเลขพัสดุ ',
                          style:
                              NotoSansThai.h1.copyWith(color: Palette.black)),
                      const SizedBox(height: 16),
                      //
                      const Text(
                        'วันที่รับ/วันที่จัดส่ง',
                        style: NotoSansThai.h2,
                      ),
                      FormBuilderDateTimePicker(
                          name: 'receiveDate',
                          onChanged: (value) {
                            controller.key.currentState?.fields['receiveDate']!
                                .save();
                          },
                          inputType: InputType.date),
                      const SizedBox(height: 8),
                      const Text('การรับใบอนุญาต', style: NotoSansThai.h2),
                      FormBuilderDropdown(
                          name: 'sign',
                          initialValue:
                              controller.osscData[index - 1].sign.toString(),
                          decoration: customAppInputDecoration(
                              hintText: 'การรับใบอนุญาต'),
                          onChanged: (value) async {
                            await controller.setSign(dropdownDetail: value!);
                          },
                          items: controller.listReciveDoc
                              .map(
                                (option) => DropdownMenuItem(
                                  value: option,
                                  child: Text(
                                    option,
                                    style: NotoSansThai.normal
                                        .copyWith(color: Palette.black),
                                  ),
                                ),
                              )
                              .toList()),
                      controller.sign.value == 'จัดส่งไปรษณีย์' ||
                              controller.sign.value == 'มารับเอง'
                          ? customFormTextField(
                              key: 'parcelNumber',
                              decoration:
                                  controller.sign.value == 'จัดส่งไปรษณีย์'
                                      ? customAppInputDecoration(
                                          hintText: 'เลขพัสดุ')
                                      : customAppInputDecoration(
                                          hintText: 'ชื่อผู้รับ'))
                          : Container(),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                            onPressed: () {
                              if (controller.key.currentState!
                                  .saveAndValidate()) {
                                controller.receiveDocuments(index);
                              }
                            },
                            child: Text(
                              'บันทึก',
                              style: NotoSansThai.normal
                                  .copyWith(color: Palette.black),
                            )),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ).then((value) => controller.sign(''));
}

Widget customFormTextField(
    {String? label,
    String? key,
    bool obscureText = false,
    TextInputType? keyboardType,
    FocusNode? focus,
    InputDecoration? decoration,
    void Function(String?)? onChange,
    String? Function(String?)? validator,
    double? padding = 16}) {
  return Padding(
    padding: EdgeInsets.only(bottom: padding!),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   label!,
        //   style: NotoSansThai.largeLabel.copyWith(color: Palette.black),
        // ),
        FormBuilderTextField(
          name: "$key",
          textInputAction: TextInputAction.next,
          focusNode: focus,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: decoration!,
          onChanged: onChange,
          validator: validator,
        ),
      ],
    ),
  );
}

customContainer(label) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Palette.grey1,
      ),
      alignment: Alignment.center,
      height: 40,
      width: 320,
      child: Text(
        label,
        style: NotoSansThai.h3.copyWith(color: Palette.black),
      ),
    );

InputDecoration customAppInputDecoration({
  IconData? prefixIcon,
  Widget? suffixIcon,
  String? hintText,
}) {
  return InputDecoration(
    filled: true,
    fillColor: Palette.white,
    // contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    hintText: hintText,
    hintStyle: NotoSansThai.normal.copyWith(color: Palette.lightGrey),
    border: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Palette.red,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Palette.mainGreen,
        width: 1.5,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    suffixIconConstraints: suffixIcon != null
        ? const BoxConstraints(
            maxWidth: 60,
            maxHeight: 24,
          )
        : null,
    suffixIcon: suffixIcon,
  );
}

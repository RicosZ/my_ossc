import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:my_ossc/modules/controllers/loc_controller.dart';
import 'package:my_ossc/modules/widgets/edit_information.dart';
import 'package:signature/signature.dart';

import '../../constants/colors.dart';
import '../../constants/notosansthai.dart';

class Menu {
  LocController controller = Get.find();
  list(int index, String company, String act, String des, BuildContext context,
          {required String receiveNumber}) =>
      Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Container(
            height: 680,
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
                    controller.filldesc(controller.listDesc
                            .contains(controller.newOssc[index].desc.toString())
                        ? controller.newOssc[index].desc.toString()
                        : 'อื่นๆ');
                    controller.selectDistrict(controller.districtList.contains(
                            controller.newOssc[index].district.toString())
                        ? controller.newOssc[index].district.toString()
                        : 'อื่นๆ');
                    ListOfContentPopup().edit(context, index);
                  },
                  child: customContainer('แก้ไขข้อมูล'),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    updateDocStatus(receiveNumber);
                  },
                  child: customContainer('อัพเดทสถานะเอกสาร'),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    receive(receiveNumber);
                  },
                  child: customContainer('รับเอกสาร'),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    appointment(receiveNumber, company);
                  },
                  child: customContainer('นัดตรวจสถานที่'),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    appointResult(receiveNumber, company, act, des);
                  },
                  child: customContainer('ส่งผลตรวจสถานที่'),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    controller.sign(controller.newOssc[index].sign.toString());
                    receiveResultDoc(receiveNumber, index, act);
                  },
                  child: customContainer('เซ็นรับผลตรวจสถานที่'),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    consider(receiveNumber, company, act, des);
                  },
                  child: customContainer('อัพโหลดใบอนุญาต'),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    licenseFee(receiveNumber, company);
                  },
                  child: customContainer('ค่าธรรมเนียมใบอนุญาต'),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    addLicense(receiveNumber, company);
                  },
                  child: customContainer('เพิ่มข้อมูลการอนุญาต'),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    controller.sign(controller.newOssc[index].sign.toString());
                    receiveDocuments(receiveNumber, index, act);
                  },
                  child: customContainer('รับเอกสาร/เพิ่มเลขพัสดุ'),
                ),
                const Spacer()
              ],
            )),
      ));
  //ANCHOR -  อัพเดทสถานะเอกสาร
  updateDocStatus(String receiveNumber) => Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Obx(() => Container(
              padding: const EdgeInsets.all(16),
              height: 300,
              width: 300,
              child: FormBuilder(
                key: controller.key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('อัพเดทสถานะเอกสาร',
                        style: NotoSansThai.h1.copyWith(color: Palette.black)),
                    // const SizedBox(height: 16),
                    SizedBox(
                      width: 240,
                      child: FormBuilderDropdown(
                          borderRadius: BorderRadius.circular(16),
                          onChanged: (value) {
                            controller.setDocStatus(dropdownDetail: value!);
                          },
                          name: 'docStatus',
                          decoration:
                              customAppInputDecoration(hintText: 'เลือกรายการ'),
                          isExpanded: true,
                          items: controller.listDocStatus
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
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: 120,
                        child: ElevatedButton(
                            onPressed: () {
                              controller.updateDoStatus(receiveNumber);
                            },
                            child: controller.loading.value
                                ? const Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Text(
                                    'ตกลง',
                                    style: NotoSansThai.normal
                                        .copyWith(color: Palette.black),
                                  )),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ));
  //ANCHOR -  รับเอกสาร
  receive(String receiveNumber) => Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Obx(() => Container(
              padding: const EdgeInsets.all(16),
              height: 300,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('รับเอกสาร',
                      style: NotoSansThai.h1.copyWith(color: Palette.black)),
                  // const SizedBox(height: 16),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'ยกเลิก',
                              style: NotoSansThai.normal
                                  .copyWith(color: Palette.black),
                            )),
                      ),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                            onPressed: () {
                              controller.receive(receiveNumber);
                            },
                            child: controller.loading.value
                                ? const Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Text(
                                    'ตกลง',
                                    style: NotoSansThai.normal
                                        .copyWith(color: Palette.black),
                                  )),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ));
  //ANCHOR -  นัดตรวจ
  appointment(String receiveNumber, String company) => Get.dialog(Dialog(
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
                  Text('นัดตรวจสถานที่ $company',
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
                        width: 260,
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
                  controller.isAppointment.value != 'ไม่มีการตรวจ' &&
                          controller.isAppointment.value != ''
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
                    child: SizedBox(
                      width: 120,
                      child: ElevatedButton(
                          onPressed: controller.loading.value
                              ? () {}
                              : () {
                                  controller.isAppointment.value != ''
                                      ? controller.addAppointment(receiveNumber)
                                      : null;
                                },
                          child: controller.loading.value
                              ? const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Text(
                                  'บันทึก',
                                  style: NotoSansThai.normal
                                      .copyWith(color: Palette.black),
                                )),
                    ),
                  )
                ],
              ),
            ))),
      )).then((value) => controller.isAppointment.value = '');
  //ANCHOR -  ส่งผลตรวจสถานที่
  appointResult(String receiveNumber, String company, String act, String des) =>
      Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Obx(() => Container(
            height: 640,
            width: 520,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('ผลการตรวจตรวจสถานที่ $company',
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
                  child: SizedBox(
                    width: 120,
                    child: ElevatedButton(
                        onPressed: controller.loading.value
                            ? () {}
                            : () {
                                controller.listFileName.isNotEmpty
                                    ? controller.sendResult(
                                        receiveNumber, act, des)
                                    : null;
                              },
                        child: controller.loading.value
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Text(
                                'บันทึก',
                                style: NotoSansThai.normal
                                    .copyWith(color: Palette.black),
                              )),
                  ),
                )
              ],
            ))),
      )).then((value) => {
            controller.listFileName.value = [],
            controller.fileNames.value = ''
          });

  //ANCHOR -  เซ็นรับผลตรวจสถานที่
  receiveResultDoc(String receiveNumber, int index, String act) => Get.dialog(
        Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Obx(
              () => Container(
                  height: 420,
                  width: 460,
                  padding: const EdgeInsets.all(16),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: FormBuilder(
                    key: controller.key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('รับเอกสารผลตรวจสถานที่ ',
                            style:
                                NotoSansThai.h1.copyWith(color: Palette.black)),
                        const SizedBox(height: 16),
                        //
                        const Text(
                          'วันที่รับ',
                          style: NotoSansThai.h2,
                        ),
                        FormBuilderDateTimePicker(
                            name: 'receiveDate',
                            onChanged: (value) {
                              controller
                                  .key.currentState?.fields['receiveDate']!
                                  .save();
                            },
                            inputType: InputType.date),
                        const SizedBox(height: 8),
                        const Text('การรับเอกสารผลตรวจสถานที่',
                            style: NotoSansThai.h2),
                        FormBuilderDropdown(
                            name: 'sign',
                            initialValue:
                                controller.newOssc[index].sign.toString(),
                            decoration: customAppInputDecoration(
                                hintText: 'การรับเอกสารผลตรวจสถานที่'),
                            onChanged: (value) async {
                              await controller.setSign(dropdownDetail: value!);
                            },
                            items: controller.listReciveResultDoc
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 16),
                              width: 300,
                              child: customFormTextField(
                                  key: 'recivedName',
                                  decoration: customAppInputDecoration(
                                      hintText: 'ชื่อผู้รับ')),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  sign(receiveNumber);
                                },
                                child: const Text('เซ็นรับ'))
                          ],
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            width: 120,
                            child: ElevatedButton(
                                onPressed: controller.loading.value
                                    ? () {}
                                    : () {
                                        if (controller.key.currentState!
                                            .saveAndValidate()) {
                                          controller.reciveResultDco(
                                              receiveNumber, act);
                                        }
                                      },
                                child: controller.loading.value
                                    ? const Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : Text(
                                        'บันทึก',
                                        style: NotoSansThai.normal
                                            .copyWith(color: Palette.black),
                                      )),
                          ),
                        )
                      ],
                    ),
                  )),
            )),
      ).then((value) {
        controller.sign('');
        controller.signature.clear();
      });

  //ANCHOR -  อัพโหลดใบอนุญาต
  consider(String receiveNumber, String company, String act, String des) =>
      Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Obx(() => Container(
            height: 640,
            width: 520,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('อัพโหลดใบอนุญาต $company',
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
                  child: SizedBox(
                    width: 120,
                    child: ElevatedButton(
                        onPressed: controller.loading.value
                            ? () {}
                            : () {
                                controller.listFileName.isNotEmpty
                                    ? controller.addLicense(
                                        receiveNumber, act, des)
                                    : null;
                              },
                        child: controller.loading.value
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Text(
                                'บันทึก',
                                style: NotoSansThai.normal
                                    .copyWith(color: Palette.black),
                              )),
                  ),
                )
              ],
            ))),
      )).then((value) => {
            controller.listFileName.value = [],
            controller.fileNames.value = ''
          });
  // //ANCHOR -  ค่าธรรมเนียมใบอนุญาต
  licenseFee(String receiveNumber, String company) => Get.dialog(
        Obx(() => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: Container(
                height: 680,
                width: 520,
                padding: const EdgeInsets.all(16),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('ค่าธรรมเนียมใบอนุญาต $company',
                        style: NotoSansThai.h1.copyWith(color: Palette.black)),
                    const SizedBox(height: 16),
                    //
                    Container(
                        width: 320,
                        height: 380,
                        decoration: BoxDecoration(
                            color: Palette.white,
                            border: Border.all(color: Palette.grey1),
                            borderRadius: BorderRadius.circular(16)),
                        child: controller.isPickedImage.value
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: () {
                                      controller.pickImage();
                                    },
                                    child: Image.memory(
                                      controller
                                          .listPickedImage!.files.first.bytes!,
                                    )),
                              )
                            : ElevatedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add,
                                      size: 38,
                                      color: Palette.white,
                                    ),
                                    Text(
                                      'อัพโหลดหลักฐานการชำระเงิน',
                                      style: NotoSansThai.h2
                                          .copyWith(color: Palette.white),
                                    )
                                  ],
                                ),
                                onPressed: () {
                                  controller.isPickedImage(false);
                                  controller.pickImage();
                                },
                              )),
                    const SizedBox(height: 16),
                    FormBuilder(
                      key: controller.key,
                      child: SizedBox(
                        width: 320,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ค่าธรรมเนียม',
                              style: NotoSansThai.h2,
                              textAlign: TextAlign.left,
                            ),
                            customFormTextField(
                                key: 'licenseFee',
                                decoration: customAppInputDecoration(
                                    hintText: 'ค่าธรรมเนียม')),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: 120,
                        child: ElevatedButton(
                            onPressed: controller.loading.value
                                ? () {}
                                : () {
                                    if (controller.key.currentState!
                                        .saveAndValidate()) {
                                      controller.addLicenseFee(receiveNumber);
                                    }
                                  },
                            child: controller.loading.value
                                ? const Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Text(
                                    'บันทึก',
                                    style: NotoSansThai.normal
                                        .copyWith(color: Palette.black),
                                  )),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ).then((value) => {
            controller.isPickedImage.value = false,
            controller.imgName(''),
          });
  //ANCHOR -  เพิ่มเลขใบอนุญาต
  addLicense(String receiveNumber, String company) => Get.dialog(
        Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: Obx(() => Container(
                height: 520,
                width: 680,
                padding: const EdgeInsets.all(16),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: FormBuilder(
                  key: controller.key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('เพิ่มข้อมูลการอนุญาต $company',
                          style:
                              NotoSansThai.h1.copyWith(color: Palette.black)),
                      const SizedBox(height: 16),
                      //
                      Row(
                        children: [
                          Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('เลขสถาณที่',
                                      style: NotoSansThai.h2),
                                  customFormTextField(
                                      key: 'placeNumber',
                                      decoration: customAppInputDecoration(
                                          hintText: 'เลขสถาณที่'))
                                ],
                              )),
                          const SizedBox(width: 24),
                          Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('เลขใบอนุญาต',
                                      style: NotoSansThai.h2),
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
                                          hintText:
                                              'เลขใบอนุญาตผู้ดำเนินการสปา'))
                                ],
                              ))
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          width: 120,
                          child: ElevatedButton(
                              onPressed: controller.loading.value
                                  ? () {}
                                  : () {
                                      if (controller.key.currentState!
                                          .saveAndValidate()) {
                                        controller
                                            .addLicenseNumber(receiveNumber);
                                      }
                                    },
                              child: controller.loading.value
                                  ? const Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : Text(
                                      'บันทึก',
                                      style: NotoSansThai.normal
                                          .copyWith(color: Palette.black),
                                    )),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ),
      );
  //ANCHOR -  รับเอกสาร
  receiveDocuments(String receiveNumber, int index, String act) => Get.dialog(
        Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Obx(
              () => Container(
                  height: 420,
                  width: 460,
                  padding: const EdgeInsets.all(16),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: FormBuilder(
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
                              controller
                                  .key.currentState?.fields['receiveDate']!
                                  .save();
                            },
                            inputType: InputType.date),
                        const SizedBox(height: 8),
                        const Text('การรับใบอนุญาต', style: NotoSansThai.h2),
                        FormBuilderDropdown(
                            name: 'sign',
                            initialValue: controller.newOssc[index].sign ?? '',
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
                                controller.sign.value == 'มารับเอง' ||
                                controller.sign.value ==
                                    'เจ้าหน้าที่รับเอกสาร' ||
                                controller.sign.value == 'รับแทน'
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 16),
                                    width: 300,
                                    child: customFormTextField(
                                        key: 'parcelNumber',
                                        decoration: controller.sign.value ==
                                                'จัดส่งไปรษณีย์'
                                            ? customAppInputDecoration(
                                                hintText: 'เลขพัสดุ')
                                            : customAppInputDecoration(
                                                hintText: 'ชื่อผู้รับ')),
                                  ),
                                  controller.sign.value == 'มารับเอง' ||
                                          controller.sign.value == 'รับแทน'
                                      ? ElevatedButton(
                                          onPressed: () {
                                            sign(receiveNumber);
                                          },
                                          child: const Text('เซ็นรับ'))
                                      : Container()
                                ],
                              )
                            : Container(),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            width: 120,
                            child: ElevatedButton(
                                onPressed: controller.loading.value
                                    ? () {}
                                    : () {
                                        if (controller.key.currentState!
                                            .saveAndValidate()) {
                                          controller.receiveDocuments(
                                              receiveNumber, index, act);
                                        }
                                      },
                                child: controller.loading.value
                                    ? const Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : Text(
                                        'บันทึก',
                                        style: NotoSansThai.normal
                                            .copyWith(color: Palette.black),
                                      )),
                          ),
                        )
                      ],
                    ),
                  )),
            )),
      ).then((value) {
        controller.sign('');
        controller.signature.clear();
      });
  sign(String receiveNumber) => Get.dialog(
        Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Container(
                height: 548,
                width: 680,
                padding: const EdgeInsets.all(16),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('เซ็นรับเอกสาร ',
                        style: NotoSansThai.h1.copyWith(color: Palette.black)),
                    const SizedBox(height: 16),
                    Signature(
                      backgroundColor: Colors.white,
                      controller: controller.signature,
                      width: 580,
                      height: 400,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              controller.signature.clear();
                            },
                            child: const Card(
                                child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('ลบ'),
                            ))),
                        InkWell(
                            onTap: () async {
                              controller.signatureImage(
                                  await controller.signature.toPngBytes());
                              Get.back();
                              // await controller.upload2Onedrive(
                              //     rawPath: controller.signatureImage.value,
                              //     fileName: 'test-signature.png');
                            },
                            child: const Card(
                                child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('บันทึก'),
                            )))
                      ],
                    ),
                  ],
                ))),
      );
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

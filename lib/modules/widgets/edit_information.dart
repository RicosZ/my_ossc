import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/notosansthai.dart';
// import '../controllers/home_controller.dart';
import '../controllers/list_of_content_controller.dart';

class ListOfContentPopup {
  ListOfContentController controller = Get.find();
  edit(BuildContext context, int index) => Get.dialog(Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: SingleChildScrollView(
            child: Obx(
              () => Container(
                  height: 640,
                  width: 1200,
                  padding: const EdgeInsets.all(32),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: FormBuilder(
                    key: controller.key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('เพิ่มข้อมูล',
                            style:
                                NotoSansThai.h1.copyWith(color: Palette.black)),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('วันที่: ',
                                  style: NotoSansThai.h3
                                      .copyWith(color: Palette.black)),
                            ),
                            Container(
                              width: 200,
                              child: FormBuilderDateTimePicker(
                                inputType: InputType.date,
                                enabled: false,
                                initialValue: controller
                                    .osscFilterData[index - 1].date!
                                    .add(const Duration(days: 1)),
                                name: 'date',
                                onChanged: (value) {
                                  controller.key.currentState?.fields['date']!
                                      .save();
                                  // controller.date.value = value!;
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return '';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            // customField(label: 'เลขรับ', key: 'recivedNumber'),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('เลขรับ: ',
                                      style: NotoSansThai.h3
                                          .copyWith(color: Palette.black)),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(
                                        //   label!,
                                        //   style: NotoSansThai.largeLabel.copyWith(color: Palette.black),
                                        // ),
                                        FormBuilderTextField(
                                          name: "recivedNumber",
                                          textInputAction: TextInputAction.next,
                                          initialValue: controller
                                              .osscFilterData[index - 1]
                                              .receiveNumber,
                                          // focusNode: focus,
                                          // obscureText: obscureText,
                                          // keyboardType: keyboardType,
                                          decoration: customInputDecoration(
                                              hintText: ''),
                                          // onChanged: onChange,
                                          // validator: validator,
                                          enabled: false,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 32),
                            customField(
                                label: 'ชื่อผู้รับอนุญาต',
                                key: 'name',
                                init: controller.osscFilterData[index - 1].customer),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customField(
                                label: 'ชื่อสถานประกอบการ',
                                key: 'company',
                                init: controller.osscFilterData[index - 1].company),
                            const SizedBox(width: 32),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('อำเภอ: ',
                                      style: NotoSansThai.h3
                                          .copyWith(color: Palette.black)),
                                ),
                                Container(
                                  width: 280,
                                  child: FormBuilderDropdown(
                                      borderRadius: BorderRadius.circular(16),
                                      onChanged: (value) {
                                        controller.setDistrict(
                                            dropdownDetail: value!);
                                      },
                                      validator: (value) {
                                        if (value == null) {
                                          return '';
                                        }
                                        return null;
                                      },
                                      initialValue: controller
                                          .osscFilterData[index - 1].district
                                          .toString(),
                                      name: 'district',
                                      decoration: customInputDecoration(
                                          hintText: 'เลือกรายการ'),
                                      isExpanded: true,
                                      items: controller.districtList
                                          .map(
                                            (option) => DropdownMenuItem(
                                              value: option,
                                              child: Text(
                                                option,
                                                style: NotoSansThai.normal
                                                    .copyWith(
                                                        color: Palette.black),
                                              ),
                                            ),
                                          )
                                          .toList()),
                                ),
                              ],
                            ),
                            const SizedBox(width: 32),
                            customField(
                                label: 'เบอร์โทร',
                                key: 'phone',
                                init: controller.osscFilterData[index - 1].tel),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('พ.ร.บ.: ',
                                      style: NotoSansThai.h3
                                          .copyWith(color: Palette.black)),
                                ),
                                Container(
                                  width: 280,
                                  child: FormBuilderDropdown(
                                      borderRadius: BorderRadius.circular(16),
                                      onChanged: (value) {
                                        controller.setAct(
                                            dropdownDetail: value!);
                                      },
                                      validator: (value) {
                                        if (value == null) {
                                          return '';
                                        }
                                        return null;
                                      },
                                      name: 'act',
                                      initialValue: controller
                                          .osscFilterData[index - 1].act
                                          .toString(),
                                      decoration: customInputDecoration(
                                          hintText: 'เลือกรายการ'),
                                      isExpanded: true,
                                      items: controller.listAnnotation
                                          .map(
                                            (option) => DropdownMenuItem(
                                              value: option,
                                              child: Text(
                                                option,
                                                style: NotoSansThai.normal
                                                    .copyWith(
                                                        color: Palette.black),
                                              ),
                                            ),
                                          )
                                          .toList()),
                                ),
                              ],
                            ),
                            const SizedBox(width: 32),
                            customField(
                                label: 'ประเภทสถานที่',
                                key: 'loaclType',
                                init: controller.osscFilterData[index - 1].type),
                            const SizedBox(width: 32),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('ธุรกรรม: ',
                                          style: NotoSansThai.h3
                                              .copyWith(color: Palette.black)),
                                    ),
                                    Container(
                                      width: 280,
                                      child: FormBuilderDropdown(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          onChanged: (value) {
                                            controller.setDesc(
                                                dropdownDetail: value!);
                                          },
                                          validator: (value) {
                                            if (value == null) {
                                              return '';
                                            }
                                            return null;
                                          },
                                          name: 'desc',
                                          initialValue: controller
                                              .osscFilterData[index - 1].desc
                                              .toString(),
                                          decoration: customInputDecoration(
                                              hintText: 'เลือกรายการ'),
                                          isExpanded: true,
                                          items: controller.listDesc
                                              .map(
                                                (option) => DropdownMenuItem(
                                                  value: option,
                                                  child: Text(
                                                    option,
                                                    style: NotoSansThai.normal
                                                        .copyWith(
                                                            color:
                                                                Palette.black),
                                                  ),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                  ],
                                ),
                                controller.desc.value == 'อื่นๆ'
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 62),
                                        child: SizedBox(
                                          width: 280,
                                          child: customFormTextField(
                                            key: 'customDesc',
                                            decoration: customInputDecoration(
                                                hintText: ''),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'กรุณากรอกข้อมูลให้ครบ';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('ค่าธรรมเนียม: ',
                                      style: NotoSansThai.h3
                                          .copyWith(color: Palette.black)),
                                ),
                                SizedBox(
                                  width: 75,
                                  child: customFormTextField(
                                      key: 'cost',
                                      decoration:
                                          customInputDecoration(hintText: ''),
                                      init: controller.osscFilterData[index - 1].cost
                                          .toString()),
                                ),
                                Text(' บาท',
                                    style: NotoSansThai.h3
                                        .copyWith(color: Palette.black))
                              ],
                            ),
                            SizedBox(width: 32),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('หลักฐานการชำระค่าธรรมเนียม',
                                    style: NotoSansThai.h3
                                        .copyWith(color: Palette.black)),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      width: 160,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Palette.storke),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Text(
                                        controller.imgName.value,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: NotoSansThai.smallLabel
                                            .copyWith(color: Palette.black),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                        onTap: () async {
                                          await controller.pickImage();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          height: 40,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Palette.mainGreen),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Text(
                                            'เลือก',
                                            style: NotoSansThai.normal
                                                .copyWith(color: Palette.black),
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('เอกสารคำขอ',
                                style: NotoSansThai.h3
                                    .copyWith(color: Palette.black)),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  width: 320,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Palette.storke),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Text(
                                    controller.fileNames.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: NotoSansThai.smallLabel
                                        .copyWith(color: Palette.black),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                    onTap: () async {
                                      await controller.pickFile(
                                          context: context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Palette.mainGreen),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Text(
                                        'เลือก',
                                        style: NotoSansThai.normal
                                            .copyWith(color: Palette.black),
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 48),

                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text('สรุปผลการรับสาย',
                        //       style:
                        //           NotoSansThai.h3.copyWith(color: Palette.black)),
                        // ),
                        // FormBuilderRadioGroup(
                        //     onChanged: (value) {
                        //       controller.result(value);
                        //       print(controller.result.value);
                        //     },
                        //     name: 'result',
                        //     options: ['เสร็จสิ้น', 'ส่งต่อ']
                        //         .map((result) =>
                        //             FormBuilderFieldOption(value: result))
                        //         .toList(growable: false)),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                              onPressed: () {
                                if (controller.key.currentState!
                                    .saveAndValidate()) {
                                  controller.editInformation(index);
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
          )))
      .then((value) => {
            controller.imgName(''),
            controller.act(''),
            controller.fileNames('')
          });
}

InputDecoration customInputDecoration({
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

Widget customField(
        {required String label,
        required String key,
        String? hint,
        String? init,
        double width = 200}) =>
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('$label: ',
              style: NotoSansThai.h3.copyWith(color: Palette.black)),
        ),
        SizedBox(
          width: width,
          child: customFormTextField(
            key: key,
            init: init,
            decoration: customInputDecoration(hintText: ''),
            validator: (value) {
              if (value == null) {
                return 'กรุณากรอกข้อมูลให้ครบ';
              }
              return null;
            },
          ),
        ),
        label == 'ค่าธรรมเนียม'
            ? Text(' บาท',
                style: NotoSansThai.h3.copyWith(color: Palette.black))
            : Container()
      ],
    );

Widget customFormTextField(
    {String? label,
    String? key,
    bool obscureText = false,
    String? init,
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
          initialValue: init,
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

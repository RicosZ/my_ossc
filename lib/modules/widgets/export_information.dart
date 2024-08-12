import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:my_ossc/modules/controllers/loc_controller.dart';

import '../../constants/colors.dart';
import '../../constants/notosansthai.dart';
import 'add_information_copy.dart';

class Export {
  LocController controller = Get.find();
  informationPopup(BuildContext context) => Get.dialog(Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: SingleChildScrollView(
            child: Obx(
              () => Container(
                  height: 520,
                  width: 400,
                  padding: const EdgeInsets.all(32),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: FormBuilder(
                    key: controller.key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('ส่งอกข้อมูล',
                            style:
                                NotoSansThai.h1.copyWith(color: Palette.black)),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('พ.ร.บ.: ',
                              style: NotoSansThai.h3
                                  .copyWith(color: Palette.black)),
                        ),
                        SizedBox(
                          width: 280,
                          child: FormBuilderDropdown(
                              initialValue: 'ทั้งหมด',
                              borderRadius: BorderRadius.circular(16),
                              onChanged: (value) {
                                controller.key.currentState?.fields['exact']!
                                    .save();
                                // controller.setAct(
                                //     dropdownDetail: value!, added: true);
                              },
                              validator: (value) {
                                if (value == null) {
                                  return '';
                                }
                                return null;
                              },
                              name: 'exact',
                              decoration: customInputDecoration(
                                  hintText: 'เลือกรายการ'),
                              isExpanded: true,
                              items: controller.listFilterAct
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
                        const SizedBox(width: 32),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('ธุรกรรม: ',
                              style: NotoSansThai.h3
                                  .copyWith(color: Palette.black)),
                        ),
                        SizedBox(
                          width: 280,
                          child: FormBuilderDropdown(
                              initialValue: 'ทั้งหมด',
                              borderRadius: BorderRadius.circular(16),
                              onChanged: (value) {
                                controller.key.currentState?.fields['exdesc']!
                                    .save();
                                // controller.setDesc(
                                //     dropdownDetail: value!, added: true);
                              },
                              validator: (value) {
                                if (value == null) {
                                  return '';
                                }
                                return null;
                              },
                              name: 'exdesc',
                              decoration: customInputDecoration(
                                  hintText: 'เลือกรายการ'),
                              isExpanded: true,
                              items: controller.listFilterDesc
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('วันที่เริ่มต้น: ',
                              style: NotoSansThai.h3
                                  .copyWith(color: Palette.black)),
                        ),
                        SizedBox(
                          width: 200,
                          child: FormBuilderDateTimePicker(
                            locale: const Locale('th', 'TH'),
                            inputType: InputType.date,
                            name: 'dateBefor',
                            onChanged: (value) {
                              controller.key.currentState?.fields['dateBefor']!
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('วันที่สิ้นสุด: ',
                              style: NotoSansThai.h3
                                  .copyWith(color: Palette.black)),
                        ),
                        SizedBox(
                          width: 200,
                          child: FormBuilderDateTimePicker(
                            locale: const Locale('th', 'TH'),
                            inputType: InputType.date,
                            name: 'dateAfter',
                            onChanged: (value) {
                              controller.key.currentState?.fields['dateAfter']!
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
                        const SizedBox(width: 48),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            width: 180,
                            child: ElevatedButton(
                                onPressed: controller.loading.value
                                    ? () {}
                                    : () {
                                        if (controller.key.currentState!
                                            .saveAndValidate()) {
                                          controller.exportDate(
                                              act: controller.key.currentState
                                                  ?.fields['exact']!.value,
                                              desc: controller.key.currentState
                                                  ?.fields['exdesc']!.value);
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
                                        'ส่งอกข้อมูล',
                                        style: NotoSansThai.normal
                                            .copyWith(color: Palette.black),
                                      )),
                          ),
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

Widget customField(
        {required String label,
        required String key,
        String? hint,
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

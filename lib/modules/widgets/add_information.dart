// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:get/get.dart';

// import '../../constants/colors.dart';
// import '../../constants/notosansthai.dart';
// import '../controllers/home_controller.dart';

// class AddInformationPopup {
//   HomeController controller = Get.find();
//   add() => Get.dialog(Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
//         child: Container(
//             height: 550,
//             width: 520,
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
//             child: FormBuilder(
//               key: controller.key,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text('เพิ่มข้อมูล',
//                       style: NotoSansThai.h1.copyWith(color: Palette.black)),
//                   const SizedBox(height: 16),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text('วันที่ :',
//                         style: NotoSansThai.h3.copyWith(color: Palette.black)),
//                   ),
//                   FormBuilderDateTimePicker(
//                     name: 'date',
//                     onChanged: (value) {
//                       controller.key.currentState?.fields['date']!.save();
//                       // controller.date.value = value!;
//                     },
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text('พ.ร.บ.',
//                         style: NotoSansThai.h3.copyWith(color: Palette.black)),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 16),
//                     child: FormBuilderDropdown(
//                         borderRadius: BorderRadius.circular(16),
//                         onChanged: (value) {
//                           controller.checkValue(dropdownDetail: value!);
//                         },
//                         name: 'act',
//                         decoration:
//                             customInputDecoration(hintText: 'เลือกรายการ'),
//                         isExpanded: true,
//                         items: controller.listAnnotation
//                             .map(
//                               (option) => DropdownMenuItem(
//                                 value: option,
//                                 child: Text(
//                                   option,
//                                   style: NotoSansThai.normal
//                                       .copyWith(color: Palette.black),
//                                 ),
//                               ),
//                             )
//                             .toList()),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text('ประเด็นสอบถาม',
//                         style: NotoSansThai.h3.copyWith(color: Palette.black)),
//                   ),
//                   customFormTextField(
//                       key: 'desc',
//                       decoration: customInputDecoration(hintText: '')),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text('สรุปผลการรับสาย',
//                         style: NotoSansThai.h3.copyWith(color: Palette.black)),
//                   ),
//                   FormBuilderRadioGroup(
//                       onChanged: (value) {
//                         controller.result(value);
//                         print(controller.result.value);
//                       },
//                       name: 'result',
//                       options: ['เสร็จสิ้น', 'ส่งต่อ']
//                           .map(
//                               (result) => FormBuilderFieldOption(value: result))
//                           .toList(growable: false)),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text('หมายเหตุ',
//                         style: NotoSansThai.h3.copyWith(color: Palette.black)),
//                   ),
//                   customFormTextField(
//                       key: 'note',
//                       decoration: customInputDecoration(hintText: '')),
//                   ElevatedButton(
//                       onPressed: () {
//                         controller.addInformation();
//                       },
//                       child: Text(
//                         'บันทึก',
//                         style:
//                             NotoSansThai.normal.copyWith(color: Palette.black),
//                       ))
//                 ],
//               ),
//             )),
//       ));
// }

// InputDecoration customInputDecoration({
//   IconData? prefixIcon,
//   Widget? suffixIcon,
//   String? hintText,
// }) {
//   return InputDecoration(
//     filled: true,
//     fillColor: Palette.white,
//     // contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//     hintText: hintText,
//     hintStyle: NotoSansThai.normal.copyWith(color: Palette.lightGrey),
//     border: OutlineInputBorder(
//       borderSide: const BorderSide(
//         color: Palette.red,
//         style: BorderStyle.solid,
//       ),
//       borderRadius: BorderRadius.circular(12),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: const BorderSide(
//         color: Palette.mainGreen,
//         width: 1.5,
//         style: BorderStyle.solid,
//       ),
//       borderRadius: BorderRadius.circular(12),
//     ),
//     suffixIconConstraints: suffixIcon != null
//         ? const BoxConstraints(
//             maxWidth: 60,
//             maxHeight: 24,
//           )
//         : null,
//     suffixIcon: suffixIcon,
//   );
// }

// Widget customFormTextField(
//     {String? label,
//     String? key,
//     bool obscureText = false,
//     TextInputType? keyboardType,
//     FocusNode? focus,
//     InputDecoration? decoration,
//     void Function(String?)? onChange,
//     String? Function(String?)? validator,
//     double? padding = 16}) {
//   return Padding(
//     padding: EdgeInsets.only(bottom: padding!),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Text(
//         //   label!,
//         //   style: NotoSansThai.largeLabel.copyWith(color: Palette.black),
//         // ),
//         FormBuilderTextField(
//           name: "$key",
//           textInputAction: TextInputAction.next,
//           focusNode: focus,
//           obscureText: obscureText,
//           keyboardType: keyboardType,
//           decoration: decoration!,
//           onChanged: onChange,
//           validator: validator,
//         ),
//       ],
//     ),
//   );
// }

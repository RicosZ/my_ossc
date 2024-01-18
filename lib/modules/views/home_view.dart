import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/notosansthai.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Center(
            child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.yellow[50]),
          width: 480,
          height: 520,
          child: FormBuilder(
            key: controller.key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                    child: Text(
                  'เข้าสู่ระบบ',
                  style: NotoSansThai.h1,
                )),
                const Spacer(),
                const Text(
                  'username:',
                  style: NotoSansThai.h3,
                ),
                customFormTextField(
                    key: 'username',
                    validator: (value) {
                      if (value == null) {
                        return '';
                      }
                      return null;
                    },
                    decoration:
                        customInputDecoration(hintText: 'ชื่อผู้ใช้งาน')),
                const SizedBox(height: 8),
                const Text(
                  'password:',
                  style: NotoSansThai.h3,
                ),
                customFormTextField(
                    key: 'password',
                    validator: (value) {
                      if (value == null) {
                        return '';
                      }
                      return null;
                    },
                    decoration: customInputDecoration(hintText: 'รหัสผ่าน')),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      if (controller.key.currentState!.saveAndValidate()) {
                        await controller.login();
                      }
                    },
                    child: const Text('เข้าสู่ระบบ')),
                const Spacer()
              ],
            ),
          ),
        )));
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
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Popup {
  loading() => Get.dialog(AlertDialog(
        content: Container(
          height: 240,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ));
}

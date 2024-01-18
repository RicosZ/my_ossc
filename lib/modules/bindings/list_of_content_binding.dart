import 'package:get/get.dart';
import 'package:my_ossc/modules/controllers/list_of_content_controller.dart';

class ListOfContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListOfContentController());
  }
}

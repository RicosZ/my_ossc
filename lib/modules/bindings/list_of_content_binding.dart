import 'package:get/get.dart';
import 'package:my_ossc/modules/controllers/list_of_content_controller.dart';
import 'package:my_ossc/modules/controllers/loc_controller.dart';

class ListOfContentBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => ListOfContentController());
    Get.lazyPut(() => LocController());
  }
}

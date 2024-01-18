import 'package:get/get.dart';
import 'package:my_ossc/modules/bindings/list_of_content_binding.dart';
import 'package:my_ossc/modules/views/list_of_content_view.dart';
import '../modules/bindings/home_binding.dart';
import '../modules/views/home_view.dart';
import 'app_routes.dart';

class AppPage {
  static var routes = [
    GetPage(
      name: Routes.home,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.listOfContent,
      page: () => ListOfContent(),
      binding: ListOfContentBinding(),
      transition: Transition.rightToLeft,
    )
  ];
}

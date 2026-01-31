import 'package:get/get.dart';
import 'package:template_app/features/home/controller/home_controller.dart';

/// Binds HomeController when Home route is pushed. Disposes on pop.
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

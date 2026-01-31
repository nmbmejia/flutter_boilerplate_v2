import 'package:get/get.dart';
import 'package:template_app/features/auth/controller/auth_controller.dart';

/// Binds AuthController when auth routes (login/register) are pushed.
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}

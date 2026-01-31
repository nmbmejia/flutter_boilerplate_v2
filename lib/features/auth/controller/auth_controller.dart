import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:template_app/app/routes.dart';
import 'package:template_app/features/auth/model/auth_model.dart';

/// Auth logic (C in MVC). Handles login/register flow.
class AuthController extends GetxController {
  final Rx<AuthModel> _model = const AuthModel().obs;

  AuthModel get model => _model.value;

  void setEmail(String value) {
    _model(_model.value.copyWith(email: value));
  }

  void setLoading(bool value) {
    _model(_model.value.copyWith(isLoading: value));
  }

  Future<void> login() async {
    setLoading(true);
    // TODO: call auth service, then navigate
    await Future.delayed(const Duration(milliseconds: 500));
    setLoading(false);
    Get.offAllNamed(Routes.home);
  }

  Future<void> register() async {
    setLoading(true);
    // TODO: call auth service, then navigate
    await Future.delayed(const Duration(milliseconds: 500));
    setLoading(false);
    Get.offAllNamed(Routes.home);
  }

  void goBack() {
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint('AuthController onInit');
  }

  @override
  void onClose() {
    debugPrint('AuthController onClose');
    super.onClose();
  }
}

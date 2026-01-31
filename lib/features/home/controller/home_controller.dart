import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:template_app/app/routes.dart';
import 'package:template_app/features/home/model/home_model.dart';
import 'package:template_app/shared/services/logger_service.dart';

/// Home screen logic (C in MVC). Reactive state via GetX.
class HomeController extends GetxController {
  final Rx<HomeModel> _model = const HomeModel().obs;

  HomeModel get model => _model.value;

  void increment() {
    _model(_model.value.copyWith(counter: _model.value.counter + 1));
  }

  void setGreeting(String value) {
    _model(_model.value.copyWith(greeting: value));
  }

  void goToLogin() {
    Get.toNamed(Routes.login);
  }

  @override
  void onInit() {
    super.onInit();
    var logger = Logger();

    logger.t("Trace log");

    logger.d("Debug log");

    logger.i("Info log");

    logger.w("Warning log");

    logger.e("Error log", error: 'Test Error');
  }

  @override
  void onClose() {
    debugPrint('HomeController onClose');
    super.onClose();
  }
}

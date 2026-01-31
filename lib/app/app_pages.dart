import 'package:get/get.dart';
import 'package:template_app/app/routes.dart';
import 'package:template_app/features/auth/auth_feature.dart';
import 'package:template_app/features/home/home_feature.dart';

/// GetX route definitions. Keeps app.dart focused on app setup.
abstract class AppPages {
  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      binding: AuthBinding(),
    ),
  ];
}

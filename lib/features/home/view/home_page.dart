import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/app/theme/theme_controller.dart';
import 'package:template_app/features/home/controller/home_controller.dart';

/// Home screen (V in MVC). UI only; logic in HomeController.
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Obx(() => Tooltip(
                message: themeController.isDark ? 'Light mode' : 'Dark mode',
                child: IconButton(
                  icon: Icon(
                    themeController.isDark ? Icons.light_mode : Icons.dark_mode,
                  ),
                  onPressed: themeController.toggleBetweenLightAndDark,
                ),
              )),
          TextButton(
            onPressed: controller.goToLogin,
            child: const Text('Login'),
          ),
        ],
      ),
      body: Obx(() {
        final model = controller.model;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                model.greeting,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                '${model.counter}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: controller.increment,
                icon: const Icon(Icons.add),
                label: const Text('Increment'),
              ),
            ],
          ),
        );
      }),
    );
  }
}

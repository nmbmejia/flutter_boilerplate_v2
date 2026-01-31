import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/core/utils/validators.dart';
import 'package:template_app/core/widgets/common_loading.dart';
import 'package:template_app/features/auth/controller/auth_controller.dart';

/// Login screen (V in MVC).
class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: controller.goBack,
        ),
      ),
      body: Obx(() {
        if (controller.model.isLoading) {
          return const CommonLoading();
        }
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: controller.setEmail,
                  validator: Validators.email,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      controller.login();
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

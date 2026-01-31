// Basic smoke test: app builds and shows the home route.

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:template_app/app/app.dart';
import 'package:template_app/app/theme/theme_controller.dart';

void main() {
  setUpAll(() {
    Get.testMode = true;
    Get.put(ThemeController());
  });

  tearDownAll(() {
    Get.reset();
  });

  testWidgets('App builds and shows Home', (WidgetTester tester) async {
    final previousErrorWidgetBuilder = ErrorWidget.builder;
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
    ErrorWidget.builder = previousErrorWidgetBuilder;
  });
}

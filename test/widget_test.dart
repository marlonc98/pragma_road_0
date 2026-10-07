import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mi_perfil_dev/data/repositories/developer/developer_repository_mock.dart';
import 'package:mi_perfil_dev/presentation/app.dart';
import 'package:mi_perfil_dev/presentation/pages/application_result/hired_page.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/detailed_developer_page.dart';
import 'package:mi_perfil_dev/presentation/pages/splash/splash_page.dart';

/// Pumps frames (letting real async work like asset loading run) until
/// [finder] matches or the attempts run out.
Future<void> pumpUntilFound(WidgetTester tester, Finder finder) async {
  for (var i = 0; i < 100 && finder.evaluate().isEmpty; i++) {
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 10)),
    );
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    PackageInfo.setMockInitialValues(
      appName: 'mi_perfil_dev',
      packageName: 'mi_perfil_dev',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
  });

  testWidgets('Splash navigates to developer page', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    expect(find.byType(SplashPage), findsOneWidget);

    await pumpUntilFound(tester, find.byType(DetailedDeveloperPage));
    expect(find.byType(DetailedDeveloperPage), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
  });

  testWidgets('Define application hire navigates to hired page', (
    tester,
  ) async {
    fakeDeveloper.hired = null;
    await tester.binding.setSurfaceSize(const Size(800, 3000));
    await tester.pumpWidget(const ProviderScope(child: App()));

    await pumpUntilFound(tester, find.byIcon(Icons.how_to_reg));
    await tester.tap(find.byIcon(Icons.how_to_reg));

    await pumpUntilFound(tester, find.byIcon(Icons.celebration));
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.byIcon(Icons.celebration));

    await pumpUntilFound(tester, find.byType(HiredPage));
    expect(find.byType(HiredPage), findsOneWidget);
    expect(fakeDeveloper.hired, isTrue);

    await tester.pump(const Duration(seconds: 2));
    await tester.binding.setSurfaceSize(null);
  });
}

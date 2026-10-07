import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mi_perfil_dev/data/repositories/developer/developer_repository_mock.dart';
import 'package:mi_perfil_dev/presentation/app.dart';
import 'package:mi_perfil_dev/presentation/pages/application_result/hired_page.dart';
import 'package:mi_perfil_dev/presentation/pages/application_result/not_hired_page.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/detailed_developer_page.dart';
import 'package:mi_perfil_dev/presentation/pages/splash/splash_page.dart';
import 'package:mi_perfil_dev/presentation/router.dart';
import 'package:mi_perfil_dev/presentation/widgets/confirmation_dialog_widget.dart';

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

/// Presses the confirm button of [count] chained
/// confirmation dialogs.
Future<void> confirmDialogs(WidgetTester tester, int count) async {
  for (var i = 0; i < count; i++) {
    await pumpUntilFound(tester, find.byType(ConfirmationDialogWidget));
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.byKey(ConfirmationDialogWidget.confirmButtonKey));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
  }
}

Future<void> openDefineApplicationSheet(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(800, 3000));
  await tester.pumpWidget(const ProviderScope(child: App()));
  router.go(SplashPage.route);
  await pumpUntilFound(tester, find.byIcon(Icons.how_to_reg));
  await tester.tap(find.byIcon(Icons.how_to_reg));
  await pumpUntilFound(tester, find.byIcon(Icons.celebration));
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    rootBundle.clear();
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
    await openDefineApplicationSheet(tester);
    await tester.tap(find.byIcon(Icons.celebration));
    await confirmDialogs(tester, 1);

    await pumpUntilFound(tester, find.byType(HiredPage));
    expect(find.byType(HiredPage), findsOneWidget);
    expect(fakeDeveloper.hired, isTrue);

    await tester.pump(const Duration(seconds: 2));
    await tester.binding.setSurfaceSize(null);
  });

  testWidgets('Rejecting asks 5 confirmations then shows not hired page', (
    tester,
  ) async {
    await openDefineApplicationSheet(tester);
    await tester.tap(find.byIcon(Icons.heart_broken));
    await confirmDialogs(tester, 5);

    await pumpUntilFound(tester, find.byType(NotHiredPage));
    expect(find.byType(NotHiredPage), findsOneWidget);
    expect(fakeDeveloper.hired, isFalse);

    await tester.pump(const Duration(seconds: 2));
    await tester.binding.setSurfaceSize(null);
  });

  testWidgets('Cancelling a reject confirmation keeps the decision', (
    tester,
  ) async {
    await openDefineApplicationSheet(tester);
    await tester.tap(find.byIcon(Icons.heart_broken));
    await confirmDialogs(tester, 2);
    await tester.tap(find.byKey(ConfirmationDialogWidget.cancelButtonKey));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));

    expect(find.byType(ConfirmationDialogWidget), findsNothing);
    expect(find.byType(NotHiredPage), findsNothing);
    expect(fakeDeveloper.hired, isNull);
    await tester.binding.setSurfaceSize(null);
  });
}

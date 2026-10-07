import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:mi_perfil_dev/presentation/app.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/detailed_developer_page.dart';
import 'package:mi_perfil_dev/presentation/pages/splash/splash_page.dart';

void main() {
  setUp(() {
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

    await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 100)));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
    expect(find.byType(DetailedDeveloperPage), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
  });
}

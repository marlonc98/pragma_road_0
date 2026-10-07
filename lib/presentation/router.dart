import 'package:go_router/go_router.dart';
import 'package:mi_perfil_dev/presentation/pages/application_result/hired_page.dart';
import 'package:mi_perfil_dev/presentation/pages/application_result/not_hired_page.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/detailed_developer_page.dart';
import 'package:mi_perfil_dev/presentation/pages/splash/splash_page.dart';

final router = GoRouter(
  initialLocation: SplashPage.route,
  routes: [
    GoRoute(
      path: SplashPage.route,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: DetailedDeveloperPage.route,
      builder: (context, state) => const DetailedDeveloperPage(),
    ),
    GoRoute(
      path: HiredPage.route,
      builder: (context, state) => const HiredPage(),
    ),
    GoRoute(
      path: NotHiredPage.route,
      builder: (context, state) => const NotHiredPage(),
    ),
  ],
);

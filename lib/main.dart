import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mi_perfil_dev/dependency_injection.dart';

import 'presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection();
  return runApp(const ProviderScope(child: App()));
}

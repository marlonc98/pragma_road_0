import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mi_perfil_dev/dependency_injection.dart';
import 'package:mi_perfil_dev/domain/states/localization_state.dart';

class LocalizationStateImpl extends Notifier<Map<String, String>>
    implements LocalizationState {
  @override
  Map<String, String> build() {
    _load();
    return {};
  }

  String _locale = 'es';
  @override
  String get locale => _locale;
  @override
  set locale(String locale) {
    _locale = locale;
    _load();
  }

  Future<void> _load() async {
    state = await ref
        .read(localizationRepositoryProvider)
        .getTranslations(_locale);
  }

  @override
  String translate(String keyText, {Map<String, dynamic>? values}) {
    String? string = state[keyText];
    if (string == null) return keyText;
    if (values == null || values.keys.isEmpty) {
      return string;
    }
    for (String key in values.keys) {
      try {
        string = string!.replaceAll('{$key}', '${values[key]}');
      } catch (e) {
        return "";
      }
    }
    return string!;
  }
}

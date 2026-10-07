import 'package:mi_perfil_dev/data/repositories/localization/api/get_language_api_impl.dart';
import 'package:mi_perfil_dev/data/repositories/localization/api/get_translatations_api_impl.dart';
import 'package:mi_perfil_dev/domain/repositories/localization_repository.dart';

class LocalizationRepositoryImpl extends LocalizationRepository {
  static String localizationRepositoryKey = 'localization_repository_key';

  @override
  Future<String> getLanguage() => getLanguageApiImpl(localizationRepositoryKey);

  @override
  Future<Map<String, String>> getTranslations(String locale) =>
      getTranslationsApiImpl(locale);
}

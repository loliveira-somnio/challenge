// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get upcomingMeetups => 'Próximos Encontros';

  @override
  String get where => 'Localização';

  @override
  String get when => 'Data e Hora';

  @override
  String get previousMeetups => 'Encontros Passados';

  @override
  String get meetups => 'Encontros';

  @override
  String get bookmarks => 'Favoritos';

  @override
  String get exploreMeetups => 'Descobrir Encontros';

  @override
  String get anyBookmark => 'Nenhum Favorito Ainda';

  @override
  String get addBookmark =>
      'Adicione encontros aos seus favoritos para encontrá-los facilmente depois.';
}

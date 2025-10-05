// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get upcomingMeetups => 'Upcoming Meetups';

  @override
  String get where => 'Location';

  @override
  String get when => 'Date & Time';

  @override
  String get previousMeetups => 'Past Meetups';

  @override
  String get meetups => 'Meetups';

  @override
  String get bookmarks => 'Bookmarks';

  @override
  String get exploreMeetups => 'Discover Meetups';

  @override
  String get anyBookmark => 'No Bookmarks Yet';

  @override
  String get addBookmark =>
      'Add meetups to your bookmarks to easily find them later.';
}

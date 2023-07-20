import 'package:easy_localization/easy_localization.dart';
import 'package:labour/src/core/resources/language_manager.dart';

String formatDateTime(String dateTime) {
  DateTime date = DateTime.parse(dateTime);

  // print(DateFormat.yMMMMd().format(date));

  return DateFormat.yMMMMd(englishLocal.toString()).format(date).toString();
}

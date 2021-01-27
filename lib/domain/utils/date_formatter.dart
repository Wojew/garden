import 'package:intl/intl.dart';

class DateHelper {
  static String format(int timestampInMillis) {
    final dateFormat = DateFormat('dd.MM.yyyy');
    return dateFormat.format(
      DateTime.fromMillisecondsSinceEpoch(timestampInMillis),
    );
  }
}

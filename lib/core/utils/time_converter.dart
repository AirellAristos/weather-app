import 'package:intl/intl.dart';

class TimeConverter {

  static String toLocalHour(int timestamp, int timezoneOffset) {
    // Timestamp ke UTC DateTime
    DateTime utcTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);

    // Tambahkan offset timezone
    DateTime localTime = utcTime.add(Duration(seconds: timezoneOffset));

    // Format ke jam:menit
    return DateFormat.Hm().format(localTime);
  }
}

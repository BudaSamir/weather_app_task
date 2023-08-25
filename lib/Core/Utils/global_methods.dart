import 'package:intl/intl.dart';

class GlobalMethods {
  static String formattedDateText(String time, bool date) {
    final parsedData = DateTime.parse(time);
    String formattedDate =
        DateFormat('yyyy-MMMM-dd HH:mm:ss').format(parsedData);
    DateTime weatherTime =
        DateFormat('yyyy-MMMM-dd HH:mm:ss').parse(formattedDate);
    if (date) {
      return '${weatherTime.day}/${weatherTime.month}/${weatherTime.year}';
    } else {
      if (weatherTime.hour.toString().length == 1) {
        return '0${weatherTime.hour}:${weatherTime.minute}0';
      } else {
        return '${weatherTime.hour}:${weatherTime.minute}0';
      }
    }
  }
}

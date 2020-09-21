import 'package:date_format/date_format.dart';

class DateLabel {
  final DateTime date;

  DateLabel(this.date);

  @override
  String toString() {
    final now = DateTime.now();
    Duration duration = now.difference(date);
    if (duration.inDays > 365) {
      return formatDate(date, [yyyy, '/', mm, '/', dd]);
    } else if (duration.inDays > 7) {
      return formatDate(date, [mm, '/', dd]);
    } else if (duration.inDays > 1) {
      return '${duration.inDays}' + '天前';
    } else if (duration.inMinutes > 1) {
      return formatDate(date, [hh, ':', nn]);
    } else {
      return "刚刚";
    }
  }
}

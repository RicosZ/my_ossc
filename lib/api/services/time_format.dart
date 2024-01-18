import 'package:intl/intl.dart';

class TimeFormat {
  String getDateTime({String? date}) {
    String dmyString;
    DateTime dateTime1;
    DateFormat formatter;
    try {
      dmyString = DateFormat('y-M-d').format(DateTime.parse(date!).toLocal());
      dateTime1 = DateFormat('y-M-d').parse(dmyString);
      formatter = DateFormat('dd MMMM yyyy hh:mmน.', 'th');
      String formattedDate = formatter.format(dateTime1);
      final splitDate = formattedDate.split(' ');
      int yyyy = int.parse(splitDate[2]) + 543;
      return '${splitDate[0]} ${splitDate[1]} $yyyy ${splitDate[3]}';
    } catch (e) {
      return date.toString();
    }
  }

  String getDate({String? date}) {
    String dmyString;
    DateTime dateTime1;
    DateFormat formatter;
    try {
      dmyString = DateFormat('y-M-d').format(DateTime.parse(date!).toLocal());
      dateTime1 = DateFormat('y-M-d').parse(dmyString);
      formatter = DateFormat('dd MMMM yyyy', 'th');
      String formattedDate = formatter.format(dateTime1);
      final splitDate = formattedDate.split(' ');
      int yyyy = int.parse(splitDate[2]) + 543;
      return '${splitDate[0]} ${splitDate[1]} $yyyy';
    } catch (e) {
      return date.toString();
    }
  }

  String getDatetime({String? date}) {
    String dmyString;
    DateTime dateTime1;
    DateFormat formatter;
    try {
      dmyString = DateFormat('y-M-d').format(DateTime.parse(date!).toLocal());
      dateTime1 = DateFormat('y-M-d').parse(dmyString);
      formatter = DateFormat('dd/MM/yyyy');
      String formattedDate = formatter.format(dateTime1);
      // final splitDate = formattedDate.split(' ');
      // int yyyy = int.parse(splitDate[2]) + 543;
      return formattedDate;
    } catch (e) {
      print(e);
      return '';
    }
  }
}

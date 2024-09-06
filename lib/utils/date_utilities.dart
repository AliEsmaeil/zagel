import 'package:intl/intl.dart';

extension DateExtension on DateTime{

  DateFormat get getFormatter => DateFormat('dd-MM-yyyy').add_jm();

  int compareTo(DateTime other) => isAfter(other)? 1 : -1 ;

  String since(){

    var now = DateTime.now();

    var diff = now.difference(this);

    // handle years
    dynamic div = diff.inDays ~/ 365;
    if(div == 1)
      {
        return '$div Year ago';
      }
    else if (div > 1){
      return '$div Years ago';
    }
    // handle months
    div = diff.inDays ~/ 30;
    if(div == 1){
      return '$div Month ago';
    }
    else if (div > 1){
      return '$div Months ago';
    }

    // handle days
    div = diff.inDays ~/ 7;
    if(div == 1){
      return '$div Week ago';
    }
    else if (div > 1){
      return '$div Weeks ago';
    }


    // handle days
    div = diff.inHours ~/ 24;
    if(div == 1){
      return '$div Day ago';
    }
    else if (div > 1){
      return '$div Days ago';
    }

    // handle hours
    div = diff.inMinutes ~/ 60;
    if(div == 1){
      return '$div Hour ago';
    }
    else if (div > 1){
      return '$div Hours ago';
    }

    // handle minutes
    div = diff.inSeconds ~/ 60;
    if(div == 1){
      return '$div Minute ago';
    }
    else if (div > 1){
      return '$div Minutes ago';
    }
    return 'Moments ago';

  }
}
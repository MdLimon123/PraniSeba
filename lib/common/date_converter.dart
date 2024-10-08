import 'package:intl/intl.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('dd-MMM-yyyy hh:mm a').format(dateTime);
  }

  static String formatDate1(DateTime dateTime) {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").format(dateTime);
  }

  static String dateFormatStyle2(DateTime dateTime) {
    String date = DateFormat('dd-MMMM-yyyy').format(dateTime);
    return date;
  }

  static DateTime convertStringToDateFormat2(String dateTime) {
    return DateFormat("dd-MMMM-yyyy").parse(dateTime);
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy').format(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("dd-MMM-yyyy hh:mm a").parse(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime, true).toLocal();
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('dd-M-yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd:MM:yy').format(isoStringToLocalDate(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('dd-MMM-yyyy').format(dateTime);
  }

  static String localDateToIsoStringWithoutHighphen(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static String localTimeToIsoString(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  static String formatDateIOS(String date, {bool isTime = false, bool isTimeDate = false}) {
    DateTime dateTime = DateTime.parse(date);
    String dat;
    if (isTime) {
      dat = DateConverter.localTimeToIsoString(dateTime);
    } else if (isTimeDate) {
      dat = DateConverter.formatDate(dateTime);
    } else {
      dat = DateConverter.localDateToIsoString(dateTime);
    }
    return dat;
  }

  static String formatDateIOSWithDay(String date,{bool isTime = false}) {
    DateTime dateTime = DateTime.parse(date);
    String dat;
    if(isTime){
      dat = localTimeToIsoString(dateTime);
    }else{
      dat = DateFormat('EEEE, d MMMM,yyyy').format(dateTime);
    }


    return dat;
  }
}

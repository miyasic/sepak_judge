import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

extension DateExtension on DateTime {
  String toYearMonthDateString() {
    return DateFormat('yyyy年M月d日').format(this);
  }

  String toYearMonthDateDOWString() {
    Intl.defaultLocale = 'ja_JP';
    initializeDateFormatting('ja');
    return DateFormat('yyyy年M月d日 (E)').format(this);
  }

  String toMonthDateDOWString() {
    Intl.defaultLocale = 'ja_JP';
    initializeDateFormatting('ja');
    return DateFormat('M月d日 (E)').format(this);
  }

  String toMonthDateTimeDOWString() {
    Intl.defaultLocale = 'ja_JP';
    initializeDateFormatting('ja');
    return DateFormat('MM/dd (E) H:mm').format(this);
  }

  String toAPIString() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
  }

  String toOpenTimeWithYearString() {
    return DateFormat('yyyy/MM/dd E HH:mm').format(this);
  }

  String toOpenTimeWithYearWithoutDOWString() {
    return DateFormat('yyyy/MM/dd HH:mm').format(this);
  }

  String toOpenTimeString() {
    return DateFormat('HH:mm').format(this);
  }

  String toAPIBirthdayString() {
    return DateFormat('yyyy-MM-dd').format(this);
  }
}

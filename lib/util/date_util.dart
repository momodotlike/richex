/**
 * @Author: Sky24n
 * @GitHub: https://github.com/Sky24n
 * @Description: Date Util.
 * @Date: 2018/9/8
 */

import 'package:get/get.dart';

/// 一些常用格式参照。可以自定义格式，例如：'yyyy/MM/dd HH:mm:ss'，'yyyy/M/d HH:mm:ss'。
/// 格式要求
/// year -> yyyy/yy   month -> MM/M    day -> dd/d
/// hour -> HH/H      minute -> mm/m   second -> ss/s
class DateFormats {
  static String full = 'yyyy-MM-dd HH:mm:ss';
  static String y_mo_d_h_m = 'yyyy-MM-dd HH:mm';
  static String y_mo_d = 'yyyy-MM-dd';
  static String line_y_mo_d = 'yyyy/MM/dd';
  static String line_d_mo_y = 'dd/MM/yyyy';
  static String y_mo = 'yyyy-MM';
  static String mo_d = 'MM-dd';
  static String mo_d_h_m = 'MM-dd HH:mm';
  static String h_m_s = 'HH:mm:ss';
  static String h_m = 'HH:mm';

  static String zh_full = 'yyyy年MM月dd日 HH时mm分ss秒';
  static String zh_y_mo_d_h_m = 'yyyy年MM月dd日 HH时mm分';
  static String line_y_mo_d_h_m = 'yyyy/MM/dd HH:mm';
  static String zh_y_mo_d = 'yyyy年MM月dd日';
  static String zh_y_mo = 'yyyy年MM月';
  static String zh_mo_d = 'MM月dd日';
  static String zh_mo_d_h_m = 'MM月dd日 HH时mm分';
  static String zh_h_m_s = 'HH时mm分ss秒';
  static String zh_h_m = 'HH时mm分';
}

/// month->days.
Map<int, int> MONTH_DAY = {
  1: 31,
  2: 28,
  3: 31,
  4: 30,
  5: 31,
  6: 30,
  7: 31,
  8: 31,
  9: 30,
  10: 31,
  11: 30,
  12: 31,
};

/// Date Util.
class DateUtil {
  /// get DateTime By DateStr.
  static DateTime? getDateTime(String dateStr, {bool? isUtc}) {
    DateTime? dateTime = DateTime.tryParse(dateStr);
    if (isUtc != null) {
      if (isUtc) {
        dateTime = dateTime?.toUtc();
      } else {
        dateTime = dateTime?.toLocal();
      }
    }
    return dateTime;
  }

  /// get DateTime By Milliseconds.
  static DateTime getDateTimeByMs(int ms, {bool isUtc = false}) {
    return DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc);
  }

  /// get DateMilliseconds By DateStr.
  static int? getDateMsByTimeStr(String dateStr, {bool? isUtc}) {
    DateTime? dateTime = getDateTime(dateStr, isUtc: isUtc);
    return dateTime?.millisecondsSinceEpoch;
  }

  /// get Now Date Milliseconds.
  static int getNowDateMs() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// get Now Date Str.(yyyy-MM-dd HH:mm:ss)
  static String getNowDateStr() {
    return formatDate(DateTime.now());
  }

  /// format date by milliseconds.
  /// milliseconds 日期毫秒
  static String formatDateMs(int ms, {bool isUtc = false, String? format}) {
    return formatDate(getDateTimeByMs(ms, isUtc: isUtc), format: format);
  }

  /// format date by date str.
  /// dateStr 日期字符串
  static String formatDateStr(String dateStr, {bool? isUtc, String? format}) {
    return formatDate(getDateTime(dateStr, isUtc: isUtc), format: format);
  }

  /// format date by DateTime.
  /// format 转换格式(已提供常用格式 DateFormats，可以自定义格式：'yyyy/MM/dd HH:mm:ss')
  /// 格式要求
  /// year -> yyyy/yy   month -> MM/M    day -> dd/d
  /// hour -> HH/H      minute -> mm/m   second -> ss/s
  static String formatDate(DateTime? dateTime, {String? format}) {
  if (dateTime == null) return '';
  format = format ?? DateFormats.full;
  if (format.contains('yy')) {
  String year = dateTime.year.toString();
  if (format.contains('yyyy')) {
  format = format.replaceAll('yyyy', year);
  } else {
  format = format.replaceAll(
  'yy', year.substring(year.length - 2, year.length));
  }
  }

  format = _comFormat(dateTime.month, format, 'M', 'MM');
  format = _comFormat(dateTime.day, format, 'd', 'dd');
  format = _comFormat(dateTime.hour, format, 'H', 'HH');
  format = _comFormat(dateTime.minute, format, 'm', 'mm');
  format = _comFormat(dateTime.second, format, 's', 'ss');
  format = _comFormat(dateTime.millisecond, format, 'S', 'SSS');

  return format;
  }

  /// com format.
  static String _comFormat(
      int value, String format, String single, String full) {
    if (format.contains(single)) {
      if (format.contains(full)) {
        format =
            format.replaceAll(full, value < 10 ? '0$value' : value.toString());
      } else {
        format = format.replaceAll(single, value.toString());
      }
    }
    return format;
  }

  /// get WeekDay.
  /// dateTime
  /// isUtc
  /// languageCode zh or en
  /// short
  static String getWeekday(DateTime? dateTime,
  {String languageCode = 'en', bool short = false}) {
  if (dateTime == null) return "";
  String weekday = "";
  switch (dateTime.weekday) {
  case 1:
  weekday = languageCode == 'zh' ? '星期一' : 'Monday';
  break;
  case 2:
  weekday = languageCode == 'zh' ? '星期二' : 'Tuesday';
  break;
  case 3:
  weekday = languageCode == 'zh' ? '星期三' : 'Wednesday';
  break;
  case 4:
  weekday = languageCode == 'zh' ? '星期四' : 'Thursday';
  break;
  case 5:
  weekday = languageCode == 'zh' ? '星期五' : 'Friday';
  break;
  case 6:
  weekday = languageCode == 'zh' ? '星期六' : 'Saturday';
  break;
  case 7:
  weekday = languageCode == 'zh' ? '星期日' : 'Sunday';
  break;
  default:
  break;
  }
  return languageCode == 'zh'
  ? (short ? weekday.replaceAll('星期', '周') : weekday)
      : weekday.substring(0, short ? 3 : weekday.length);
  }

  /// get WeekDay By Milliseconds.
  static String getWeekdayByMs(int milliseconds,
      {bool isUtc = false, String languageCode = 'en', bool short = false}) {
    DateTime dateTime = getDateTimeByMs(milliseconds, isUtc: isUtc);
    return getWeekday(dateTime, languageCode: languageCode, short: short);
  }

  /// get day of year.
  /// 在今年的第几天.
  static int getDayOfYear(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    int days = dateTime.day;
    for (int i = 1; i < month; i++) {
      days = days + MONTH_DAY[i]!;
    }
    if (isLeapYearByYear(year) && month > 2) {
    days = days + 1;
    }
    return days;
  }

  /// get day of year.
  /// 在今年的第几天.
  static int getDayOfYearByMs(int ms, {bool isUtc = false}) {
    return getDayOfYear(DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc));
  }

  /// is today.
  /// 是否是当天.
  static bool isToday(int? milliseconds, {bool isUtc = false, int? locMs}) {
  if (milliseconds == null || milliseconds == 0) return false;
     DateTime old = DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: isUtc);
     DateTime now;
  if (locMs != null) {
    now = DateUtil.getDateTimeByMs(locMs);
  } else {
    now = isUtc ? DateTime.now().toUtc() : DateTime.now().toLocal();
  }
     return old.year == now.year && old.month == now.month && old.day == now.day;
  }


  /// is yesterday by dateTime.
  /// 是否是昨天.
  static bool isYesterday(DateTime dateTime, DateTime locDateTime) {
    if (yearIsEqual(dateTime, locDateTime)) {
      int spDay = getDayOfYear(locDateTime) - getDayOfYear(dateTime);
      return spDay == 1;
    } else {
      return ((locDateTime.year - dateTime.year == 1) &&
          dateTime.month == 12 &&
          locDateTime.month == 1 &&
          dateTime.day == 31 &&
          locDateTime.day == 1);
    }
  }

  /// 前几天； 默认判断是否是昨天
  static bool isBeforeDays(DateTime dateTime, DateTime locDateTime,{int days = 1}) {
    if (yearIsEqual(dateTime, locDateTime)) {
      int spDay = getDayOfYear(locDateTime) - getDayOfYear(dateTime);
      if(days !=1) {
        return spDay > days;
      }
      return spDay == 1;
    } else {
      return ((locDateTime.year - dateTime.year == 1) &&
          dateTime.month == 12 &&
          locDateTime.month == 1 &&
          dateTime.day == 31 &&
          locDateTime.day == 1);
    }
  }

  /// is yesterday by millis.
  /// 是否是昨天.
  static bool isYesterdayByMs(int ms, int locMs) {
    return isYesterday(DateTime.fromMillisecondsSinceEpoch(ms),
        DateTime.fromMillisecondsSinceEpoch(locMs));
  }

  /// is Week.
  /// 是否是本周.
  static bool isWeek(int? ms, {bool isUtc = false, int? locMs}) {
  if (ms == null || ms <= 0) {
  return false;
  }
  DateTime _old = DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc);
  DateTime _now;
  if (locMs != null) {
  _now = DateUtil.getDateTimeByMs(locMs, isUtc: isUtc);
  } else {
  _now = isUtc ? DateTime.now().toUtc() : DateTime.now().toLocal();
  }

  DateTime old =
  _now.millisecondsSinceEpoch > _old.millisecondsSinceEpoch ? _old : _now;
  DateTime now =
  _now.millisecondsSinceEpoch > _old.millisecondsSinceEpoch ? _now : _old;
  return (now.weekday >= old.weekday) &&
  (now.millisecondsSinceEpoch - old.millisecondsSinceEpoch <=
  7 * 24 * 60 * 60 * 1000);
  }

  /// year is equal.
  /// 是否同年.
  static bool yearIsEqual(DateTime dateTime, DateTime locDateTime) {
    return dateTime.year == locDateTime.year;
  }

  /// year is equal.
  /// 是否同年.
  static bool yearIsEqualByMs(int ms, int locMs) {
    return yearIsEqual(DateTime.fromMillisecondsSinceEpoch(ms),
        DateTime.fromMillisecondsSinceEpoch(locMs));
  }

  /// Return whether it is leap year.
  /// 是否是闰年
  static bool isLeapYear(DateTime dateTime) {
    return isLeapYearByYear(dateTime.year);
  }

  /// Return whether it is leap year.
  /// 是否是闰年
  static bool isLeapYearByYear(int year) {
    return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
  }

  /// 比较大小
  static bool isBefore(String firstDay,String lastDay) {
    return DateTime.parse(lastDay).difference( DateTime.parse(firstDay)) > const Duration(seconds: 1);
  }

  /// return 2022/02/23
  static String formatLineTime(String str,{bool isDayFirst = false}){
    return formatDateStr(str,format: isDayFirst ? DateFormats.line_y_mo_d : DateFormats.line_d_mo_y).toString();
  }

  static final List<String> englishMonth = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static String parseCalendarDate(DateTime pageTime) {
    String month = DateUtil.englishMonth[pageTime.month-1];
    int year = pageTime.year;
    return '$month  $year';
  }

  // 是否逾期
  static bool isOverDue(String endTime,{int delDay = 0,String startTime = ''}) {
    if(endTime == startTime) {
      bool isBeforeToday = DateUtil.isBeforeDays(DateUtil.getDateTime(endTime)!, DateTime.now(),days: delDay);
      return isBeforeToday;
    }
    bool overDue = false;
    if(delDay == 0) {
      overDue = DateUtil.isBefore(endTime, DateUtil.formatDate(DateTime.now().add(const Duration(days: 1))));
    }
    overDue = DateUtil.isBefore(endTime, DateUtil.formatDate(DateTime.now().subtract(Duration(days: delDay))));
    return overDue;
  }

  static bool isSameDay(String day1, DateTime day2) {
    var d1 = DateUtil.formatDateStr(day1,format: DateFormats.y_mo_d);
    var d2 = DateUtil.formatDate(day2,format: DateFormats.y_mo_d);
    return d1 == d2;
  }

  static bool isSameDayByStr(String day1, String day2) {
    var d1 = DateUtil.formatDateStr(day1,format: DateFormats.y_mo_d);
    var d2 = DateUtil.formatDateStr(day2,format: DateFormats.y_mo_d);
    return d1 == d2;
  }

  // 获取相差天数，第一个为开始时间，第二个为结束时间
  static int getDayInterval(String firstDay,String lastDay) {
    // 返回说明： -2 前天； -1 昨天； 0 今天； 1 明天； 2 后天； 8 未来七天；
    DateTime day1 = getDateTime(firstDay)!;
    DateTime day2 = getDateTime(lastDay)!;
    if (yearIsEqual(day1, day2)) {
      int spDay = getDayOfYear(day1) - getDayOfYear(day2);
      return spDay;
    } else {
      return -1; // 不是同一年，先返回 -1
    }
  }
}

class DateCountDownUtil{

  //根据总秒数转换为对应的 hh:mm:ss 格式
  static String constructTime(int seconds) {
    int day = seconds ~/3600 ~/24;
    int hour = seconds ~/ 3600 %24;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    if(day != 0){
      return formatTime(day)+'天'.tr +formatTime(hour) + "小时".tr + formatTime(minute) + "分".tr + formatTime(second)+'秒'.tr;
    }else if(hour != 0){
      return formatTime(hour) + "小时".tr + formatTime(minute) + "分".tr + formatTime(second)+'秒'.tr;
    }else if(minute !=0){
      return formatTime(minute) + "分".tr + formatTime(second)+'秒'.tr;
    }else if(second!=0){
      return formatTime(second)+'秒'.tr;
    }else {
      return '';
    }
  }

  //数字格式化，将 0~9 的时间转换为 00~09
  static String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  //日期时间差 秒数
  static difference(startTime,endTime){
    return DateTime.parse(startTime).difference(endTime).inSeconds;
  }
}


class DateUtils {
  static int getTimeStamp() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  static logStr(StringBuffer logs, String str) {
    logs.writeln('${new DateTime.now().toString()} :::::   $str');
    return logs;
  }

  static String getCurrentDay() {
    return new DateTime.now().toString().split(' ')[0];
  }
}

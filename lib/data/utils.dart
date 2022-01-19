// 날짜를 숫자로 표현하고 변경하거나
// 숫자를 다시 날짜로 변경하는 기능을 여기서 추가
class Utils{
  static int getFormatTime(DateTime date){
    // 날짜를 받아오면 숫자로 변경
    return int.parse("${date.year}${makeTwoDigit(date.month)}${makeTwoDigit(date.day)}");
  }


  static DateTime numToDateTime(int date){
    String _d = date.toString();
    // 20210708
    int year = int.parse(_d.substring(0,4));
    int month = int.parse(_d.substring(4,6));
    int day = int.parse(_d.substring(6,8));

    return DateTime(year, month , day);
  }


  // 1자리 수 월은 1개로 나오는데 2자리는 2개로 나옴
  // 따라서 2자릿수로 맞춰주는 작업이 필요
  static String makeTwoDigit(int num){
    return num.toString().padLeft(2, "0");
  }
}
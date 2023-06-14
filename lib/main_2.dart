void main() async{
  var startTimeInt = 1687190400; // 2023-06-20 00:00:00
  var today = DateTime.now();
  var todaySecond = DateTime.now().millisecondsSinceEpoch; // 毫秒
  bool isAfter = today.isAfter(DateTime.fromMillisecondsSinceEpoch(startTimeInt * 1000));
  print('是否后面====$isAfter');
  if(!isAfter) {
    print('我进来---');
    var res = ((startTimeInt * 1000 - todaySecond) / 1000).toInt();
    print('countTotalTime====${res}'); //700489  // 700489
  }
}
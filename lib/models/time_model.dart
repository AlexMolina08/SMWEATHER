/*
*
* La clase Time contiene información sobre el día, la hora y la zona horaria
*
* */


class TimeData {

  final String time,
        date;

  TimeData({required this.time, required this.date});

  factory TimeData.fromJson(Map<String,dynamic> json){
    return TimeData(
      date: json['date'],
      time: json['time_12']
    );
  }
}
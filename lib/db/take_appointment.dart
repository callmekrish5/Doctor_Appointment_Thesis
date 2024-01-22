class TakeAppointment {
  final int id;
  final String doctorName;
  final String hospitalName;
  final String time;
  final String date;

  TakeAppointment({
    required this.id,
    required this.doctorName,
    required this.hospitalName,
    required this.time,
    required this.date,
  });

  @override
  String toString() {
    return 'id: $id, doctor name ; $doctorName, hospital: $hospitalName, time: $time, date: $date';
  }
}

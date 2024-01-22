class Doctor {
  final int id;
  final String fullName;
  final String specialization;
  final String consultantFee;
  final String availableTime;
  final String depatureTime;
  final String picture;
  final String hospitalName;

  Doctor({
    required this.id,
    required this.fullName,
    required this.specialization,
    required this.availableTime,
    required this.depatureTime,
    required this.consultantFee,
    required this.picture,
    required this.hospitalName,
  });
}

import 'take_appointment.dart';

import 'doctor.dart';

class Data {
  static List<Doctor> doctorList = [
    Doctor(
      id: 1,
      fullName: 'Ram Karki',
      specialization: 'Teeth',
      depatureTime: '5:00 PM',
      hospitalName: 'Sagarmatha Swastha Kendra Aspathal',
      picture:
          'https://t3.ftcdn.net/jpg/02/60/04/08/360_F_260040863_fYxB1SnrzgJ9AOkcT0hoe7IEFtsPiHAD.jpg',
      availableTime: '2:00 PM',
      consultantFee: '500',
    ),
    Doctor(
      id: 2,
      fullName: 'Ganga Tamang',
      specialization: 'Eye',
      availableTime: '9:00 AM',
      depatureTime: '11:00 AM',
      hospitalName: 'Joti Hosiptal',
      consultantFee: '800',
      picture:
          'https://www.shutterstock.com/image-photo/medical-concept-indian-beautiful-female-600nw-1635029716.jpg',
    ),
    Doctor(
      id: 3,
      fullName: 'Shushila Magar',
      hospitalName: 'Bir Hospital',
      specialization: 'Heart',
      availableTime: '10:00 AM',
      depatureTime: '2:00 PM',
      consultantFee: '1500',
      picture:
          'https://cdn.pixabay.com/photo/2017/03/14/03/20/woman-2141808_1280.jpg',
    ),
    Doctor(
      id: 4,
      fullName: 'Amit Shrestha',
      hospitalName: 'Cancer Hospital',
      specialization: 'Cancer',
      availableTime: '10:00 AM',
      depatureTime: '5:00 PM',
      consultantFee: '2000',
      picture:
          'https://www.nch.com.np/wp-content/uploads/2020/06/Dr-Amit-Shrestha-scaled.jpg',
    ),
  ];

  static List<TakeAppointment> myAppointmentList = [
    TakeAppointment(
      id: 1,
      doctorName: 'Ganga Tamang',
      hospitalName: 'Joti Hospital',
      time: '10:00 AM',
      date: '26/12/2023',
    ),
    TakeAppointment(
        id: 2,
        doctorName: 'Amit Shrestha',
        hospitalName: 'Cancer Hospital',
        time: '11:00 AM',
        date: '11/12/2023')
  ];
}

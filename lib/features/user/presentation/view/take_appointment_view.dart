import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../../config/router/app_route.dart';
import '../../../../db/doctor.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../../../db/data.dart';
import '../../../../db/take_appointment.dart';

class TakeAppointmentView extends StatefulWidget {
  const TakeAppointmentView({Key? key}) : super(key: key);

  @override
  State<TakeAppointmentView> createState() => _TakeAppointmentViewState();
}

class _TakeAppointmentViewState extends State<TakeAppointmentView> {
  late Doctor _doctor;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? appointedDate;

  String? _time;

  final _gap = const SizedBox(height: 14);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _doctor = ModalRoute.of(context)!.settings.arguments as Doctor;
  }

  void _saveAppointment() {
    TakeAppointment appointment = TakeAppointment(
        id: Data.myAppointmentList.length + 1,
        doctorName: _doctor.fullName,
        hospitalName: _doctor.hospitalName,
        time: _time.toString(),
        // date:
        //     '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
        date: appointedDate!);

    setState(() {
      Data.myAppointmentList.insert(0, appointment);
    });

    print('Appointment: $appointment');
    Navigator.popAndPushNamed(context, AppRoute.homeRoute);

    showSnackBar(
        message: 'Appointment submitted successfully.', context: context);
  }

  void _submit() {
    if (appointedDate != null && _time != null) {
      Alert(
        context: context,
        type: AlertType.info,
        desc: "Are you sure want to Appointment ?",
        buttons: [
          DialogButton(
            onPressed: _saveAppointment,
            color: const Color.fromRGBO(0, 179, 134, 1.0),
            child: const Text(
              "Yes",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DialogButton(
            onPressed: () => Navigator.pop(context),
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0)
            ]),
            child: const Text(
              "No",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ).show();
    } else {
      showSnackBar(
          message: 'Choose date and time.',
          context: context,
          color: Colors.red);
    }
  }

  void _selectDate() {
    log('Select date');
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(
          2024), // allow to add today or tomorrow days but not past date
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;

        String dayTime = 'AM';

        if (_selectedTime!.hour > 12) {
          dayTime = 'PM';
        }

        _time =
            '${_selectedTime!.hour % 12} : ${_selectedTime!.minute} $dayTime';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Appointment'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 150,
                backgroundImage: NetworkImage(_doctor.picture.toString()),
              ),
              _gap,
              Text(
                _doctor.fullName,
                style: const TextStyle(fontSize: 18),
              ),
              _gap,
              Text(
                "Hospital: ${_doctor.hospitalName}",
                style: const TextStyle(fontSize: 18),
              ),
              _gap,
              Text(
                "Consultant fee: Rs${_doctor.consultantFee}/-",
                style: const TextStyle(fontSize: 18),
              ),
              _gap,
              Row(
                children: [
                  TextButton(
                    onPressed: _selectDate,
                    child: const Text(
                      'Choose date: ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  // Text(
                  //   _selectedDate != null
                  //       ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                  //       : 'Not selected',
                  //   style: const TextStyle(fontSize: 18),
                  // ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        appointedDate = value;
                      },
                    ),
                  )
                ],
              ),
              _gap,
              Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      await _selectTime();
                    },
                    child: const Text(
                      'Choose time: ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Text(
                    _selectedTime != null ? '$_time' : 'Not selected',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              _gap,
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        _submit();
                      },
                      child: const Text('Continue')))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../db/take_appointment.dart';
import '../../../../db/data.dart';
import '../../domain/entity/appointment_entity.dart';
import '../viewmodel/appointment_view_model.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';

class AppointmentView extends ConsumerStatefulWidget {
  const AppointmentView({super.key});

  @override
  ConsumerState<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends ConsumerState<AppointmentView> {
  @override
  Widget build(BuildContext context) {
    var AppointmentState = ref.watch(appointmentViewModelProvider);
    List<AppointmentEntity> appointmentList = AppointmentState.appointments;

    List<TakeAppointment> myAppointments = Data.myAppointmentList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Appointments'),
      ),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref
                .read(appointmentViewModelProvider.notifier)
                .getAppointments();
            showSnackBar(message: 'Refressing...', context: context);
          },
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.black], // Add your gradient colors
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    const SizedBox(height: 16),
                    for (int i = 0; i < myAppointments.length; i++) ...{
                      AppointmentCard(
                        date: myAppointments[i].date,
                        time: myAppointments[i].time,
                        hospitalName: myAppointments[i].hospitalName,
                        doctorName: myAppointments[i].doctorName,
                      )
                    }
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentCard extends StatefulWidget {
  final String date;
  final String time;
  final String hospitalName;
  final String doctorName;

  const AppointmentCard({
    super.key,
    required this.date,
    required this.time,
    required this.hospitalName,
    required this.doctorName,
  });

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 140,
      width: double.infinity, // Adjust the height as per your preference
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dr.${widget.doctorName}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Hospital: ${widget.hospitalName}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Time: ${widget.time}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Date: ${widget.date}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

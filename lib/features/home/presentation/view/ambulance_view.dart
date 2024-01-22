import 'package:flutter/material.dart';

class Ambulance {
  final String id;
  final String driverName;
  final String contact;
  final String hospital;
  final String location;

  Ambulance({
    required this.id,
    required this.driverName,
    required this.contact,
    required this.hospital,
    required this.location,
  });
}

class AmbulanceView extends StatelessWidget {
  final List<Ambulance> ambulances = [
    Ambulance(
      id: "1",
      driverName: "Santosh Khanal",
      contact: "9877678768",
      hospital: "Mother land hospital",
      location: "Pepsicola, Bhaktapur",
    ),
    Ambulance(
      id: "2",
      driverName: "Ramesh Sharma",
      contact: "9871234567",
      hospital: "City Medical Center",
      location: "Koteswor, Kathmandu",
    ),
    Ambulance(
      id: "3",
      driverName: "Sita Rai",
      contact: "9879876543",
      hospital: "Everest Hospital",
      location: "Thamel, Kathmandu",
    ),
    Ambulance(
      id: "4",
      driverName: "Bikash Tamang",
      contact: "9878765432",
      hospital: "Green Valley Medical",
      location: "Baneshwor, Kathmandu",
    ),
    Ambulance(
      id: "5",
      driverName: "Anita Shrestha",
      contact: "9876543210",
      hospital: "Sunrise Hospital",
      location: "New Baneshwor, Kathmandu",
    ),
  ];

  AmbulanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ambulance Details'),
        ),
        body: ListView.builder(
          itemCount: ambulances.length,
          itemBuilder: (context, index) {
            return buildAmbulanceCard(ambulances[index]);
          },
        ),
      ),
    );
  }

  Widget buildAmbulanceCard(Ambulance ambulance) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              'Ambulance: ${ambulance.id}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Driver Name: ${ambulance.driverName}'),
                Text('Contact: ${ambulance.contact}'),
                Text('Hospital: ${ambulance.hospital}'),
                Text('Location: ${ambulance.location}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

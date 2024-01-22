import 'package:flutter/material.dart';
import 'package:my_app/features/home/presentation/view/ambulance_view.dart';

import '../../../appointment/presentation/view/appointments.dart';
import '../../../doctor/presentation/view/applyfordoctor.dart';
import '../../../user/presentation/view/userprofile.dart';
import 'dashboard.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  List<Widget> screens = [
    const HomePage(),
    const ApplyForDoctorView(),
    const AppointmentView(),
    // const DoctorListPage(),
    const UserProfilePage(),
    AmbulanceView()
    // const UserListPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.health_and_safety),
          label: 'Apply doctor',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Appointments',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_hospital),
          label: 'Ambulance',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.white,
      onTap: _onItemTapped,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: _buildBottomNavigationBar(),
      // backgroundColor: const Color(0xffF1F4EE),
      body: screens[_selectedIndex],
    );
  }
}

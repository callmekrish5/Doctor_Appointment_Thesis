
import '../../features/appointment/presentation/view/doctorappointment.dart';
import '../../features/home/presentation/view/ambulance_view.dart';
import '../../features/home/presentation/view/dashboard.dart';
import '../../features/home/presentation/view/admin/adminnavigation.dart';
import '../../features/home/presentation/view/bottom_navigation.dart';
import '../../features/user/presentation/view/take_appointment_view.dart';
import '../../features/user/presentation/view/userprofile.dart';

import '../../features/auth/presentation/view/login_view.dart';
import '../../features/auth/presentation/view/register_view.dart';
// import '../../features/home/presentation/view/home_view.dart';
import '../../features/splash/presentation/view/splash_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/splash';
  static const String homeRoute = '/home';
  static const String doctorRoute = '/doctor';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static String adminRoute = '/admin';
  static String appointmentRoute = "/appointment";
  static String profileRoute = '/profile';
  static String takeAppointmentROute = '/takeAppointment';
  static String ambulanceRoute = '/ambulance';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashView(),
      takeAppointmentROute: (context) => const TakeAppointmentView(),
      loginRoute: (context) => const LogInView(),
      homeRoute: (context) => const HomeView(),
      doctorRoute: (context) => const HomePage(),
      registerRoute: (context) => const RegisterView(),
      adminRoute: (context) => const AdminView(),
      appointmentRoute: (context) => const DoctorAppointmentPage(),
      profileRoute: (context) => const UserProfilePage(),
      ambulanceRoute: (context) =>  AmbulanceView(),
    };
  }
}

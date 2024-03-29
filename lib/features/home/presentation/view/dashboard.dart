import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../db/data.dart';
import '../../../../db/doctor.dart';
import '../../../../config/router/app_route.dart';
import 'category.dart';
import '../viewmodel/logout_view_model.dart';
import 'package:shake/shake.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../domain/entity/home_entity.dart';
import '../viewmodel/home_view_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late ShakeDetector detector;

  final List<Doctor> _doctors = Data.doctorList;

  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        ref.read(logoutViewModelProvider.notifier).logout(context);
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 6,
    );
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

  @override
  void dispose() {
    super.dispose();
    detector.stopListening();
  }

  final _gap = const SizedBox(height: 14);
  @override
  Widget build(BuildContext context) {
    var DoctorState = ref.watch(homeViewModelProvider);
    var internetState = ref.watch(connectivityStatusProvider);
    List<HomeEntity> homeList = DoctorState.doctors;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
              color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // back
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hello, \nWelcome',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      // fontFamily: 'OpenSans',
                      fontSize: 30,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ref
                          .read(logoutViewModelProvider.notifier)
                          .logout(context);
                    },
                    icon: const Icon(
                      Icons.logout,
                      size: 40,
                    ),
                  ),
                ],
              ),
              _gap,
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [

                      
                      CategoryScreen(
                        categoryName: 'Dentist',
                        iconImage:
                            'https://static.thenounproject.com/png/100330-200.png',
                      ),
                      CategoryScreen(
                        categoryName: 'Surgeon',
                        iconImage:
                            'https://cdn-icons-png.flaticon.com/512/5793/5793639.png',
                      ),
                      CategoryScreen(
                        categoryName: 'Cardiologist',
                        iconImage:
                            'https://cdn-icons-png.flaticon.com/512/3467/3467794.png',
                      ),
                      CategoryScreen(
                        categoryName: 'Therapist',
                        iconImage:
                            'https://cdn-icons-png.flaticon.com/512/1971/1971437.png',
                      ),
                    ],
                  ),
                ),
              ),
              
             
              _gap,
              const Text(
                    'All Doctors',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      // fontFamily: 'OpenSans',
                      fontSize: 30,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  _gap,
              for (int i = 0; i < _doctors.length; i++) ...{
                GestureDetector(
                  onTap: () {
                    print('Doctor name: ${_doctors[i].fullName}');

                    Navigator.pushNamed(context, AppRoute.takeAppointmentROute, arguments: _doctors[i]);
                  },
                  child: Card(
                    elevation: 5, // Added elevation for a shadow effect
                    margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16), // Added margin for spacing

                    // Changed color to a more subtle shade
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Added rounded corners
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),

                            // Wrapped CircleAvatar with a Container for more control
                            leading: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(_doctors[i].picture),
                                ),
                              ),
                            ),

                            // Changed title text style for better readability
                            title: Text(
                              _doctors[i].fullName.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            // Changed subtitle text color for better contrast
                            subtitle: Text(
                              _doctors[i].specialization,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Text(
                            'Available time: ${_doctors[i].availableTime}',
                          ),
                          Text(
                            'Depature time: ${_doctors[i].depatureTime}',
                          ),
                          Text(
                            'Consultant fee: ${_doctors[i].consultantFee}',
                          ),
                          Text(
                            'Hospital: ${_doctors[i].hospitalName}',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}




// body: RefreshIndicator(
//         onRefresh: () async {
//           await ref.read(homeViewModelProvider.notifier).getAllDoctors();
//           showSnackBar(message: 'Refressing...', context: context);
//         },
//         child: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.white, Colors.black], // Add your gradient colors
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 15,
//                 vertical: 15,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Hello, \nWelcome',
//                         style: TextStyle(
//                           fontFamily: 'Montserrat',
//                           // fontFamily: 'OpenSans',
//                           fontSize: 30,
//                           fontWeight: FontWeight.w100,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           ref.read(logoutViewModelProvider.notifier).logout(context);
//                         },
//                         icon: const Icon(
//                           Icons.logout,
//                           size: 40,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
                 
//                   const SizedBox(
//                     height: 25,
//                   ),
//                   // Category
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Category',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   SizedBox(
//                     height: 80,
//                     child: ListView(
//                       scrollDirection: Axis.horizontal,
//                       children: const [
//                         CategoryScreen(
//                           categoryName: 'Dentist',
//                           iconImage:
//                               'https://static.thenounproject.com/png/100330-200.png',
//                         ),
//                         CategoryScreen(
//                           categoryName: 'Surgeon',
//                           iconImage:
//                               'https://cdn-icons-png.flaticon.com/512/5793/5793639.png',
//                         ),
//                         CategoryScreen(
//                           categoryName: 'Cardiologist',
//                           iconImage:
//                               'https://cdn-icons-png.flaticon.com/512/3467/3467794.png',
//                         ),
//                         CategoryScreen(
//                           categoryName: 'Therapist',
//                           iconImage:
//                               'https://cdn-icons-png.flaticon.com/512/1971/1971437.png',
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 25,
//                   ),
        
//                   ///Doctor List
//                    const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Doctor List',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                         SizedBox(height: 20),
                    
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 25,
//                   ),
//                   Expanded(
//           child: ListView.builder(
//             scrollDirection: Axis.vertical,
//             itemCount: homeList.length,
//             itemBuilder: (context, i) {
//           return Column(
//             children: [
//               DoctorList(
//                 DoctorImage: 'https://th.bing.com/th/id/OIP.xf9TkDAN4uIhHezoIacDhQHaHk?pid=ImgDet&w=920&h=940&rs=1',
//                 doctorname: "${homeList[i].firstName} ${homeList[i].lastName}",
//                 doctorspeciality: homeList[i].specialization,
//               ),
//               const SizedBox(height: 15), // Add space after each doctor list
//             ],
//           );
//             },
//           ),
//         ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),

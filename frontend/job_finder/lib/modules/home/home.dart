import 'dart:async';

import 'package:flutter/material.dart';
import 'package:job_finder/global/config/local_storage.dart';
import 'package:job_finder/modules/home/screens/browse.dart';
import 'package:job_finder/modules/home/screens/resume.dart';
import 'package:job_finder/modules/home/screens/settings.dart';
import 'package:job_finder/modules/home/screens/your_jobs.dart';
import '../../global/models/user.dart';
import '../../global/widgets/custom_app_bar.dart';
import '../../global/widgets/dialog.dart';
import 'controllers/user_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
  static const String id = 'Home';
}

class _HomePageState extends State<HomePage> {
  String userID = "";
  Timer? timer;
  late List<Widget> childsList = [
    Browse(
      userId: userID ,
    ),
    const YourJobs(),
    const ResumeScreen(),
    const Settings(),
  ];
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 5),
        (Timer t) => UserController.fetchUserData());

    LocalStrorageConfig.getUserData().then((value) {
      setState(() {
        userID = value!.userId!;
      });
    });
    super.initState();
  }

  int currentIndex = 0;
  @override
  void dispose() {
    UserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(49, 44, 191, 0.81),
                Color.fromRGBO(4, 178, 217, 0.7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              StreamBuilder<dynamic>(
                stream: UserController.userDataStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return snapshot.data!.fold((l) {
                      showErrorDialog(context, l);
                      return const Placeholder();
                    }, (r) {
                      User currentUser = r;
                      return CustomAppBar(
                        userName: currentUser.name!,
                      );
                    });
                  } else {
                    return const Text('No data available');
                  }
                },
              ),
              childsList[currentIndex],
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          fixedColor: Colors.black,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.document_scanner, color: Colors.black),
                label: "Jobs"),
            BottomNavigationBarItem(
                icon: Icon(Icons.document_scanner, color: Colors.black),
                label: "Resume"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings, color: Colors.black),
                label: "Settings"),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class InternetConnectionProvider {
  bool? get isConnected => null;

  checkInternetConnection() {}
}

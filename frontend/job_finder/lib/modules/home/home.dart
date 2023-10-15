import 'dart:async';

import 'package:flutter/material.dart';
import 'package:job_finder/global/widgets/custom_chip.dart';
import 'package:job_finder/modules/home/screens/browse.dart';
import 'package:job_finder/modules/home/screens/resume.dart';
import 'package:job_finder/modules/home/screens/your_jobs.dart';
import 'package:provider/provider.dart';

import '../../global/config/network/network_provider.dart';
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
  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 5),
        (Timer t) => UserController.fetchUserData());
    super.initState();
  }

  List<Widget> childsList = [
    const Browse(),
    const YourJobs(),
    const ResumeScreen(),
    Container(
      color: Colors.blue,
      height: 200,
      width: 500,
    ),
  ];
  int currentIndex = 0;
  bool isBrowseSelected = true;
  bool isJobsSelected = false;
  bool isResumeSelected = false;
  bool isSettingsSelected = false;
  @override
  void dispose() {
    UserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Provider<InternetConnectionProvider>(
          create: (_) => InternetConnectionProvider(),
          child: Builder(
            builder: (context) {
              final internetConnectionProvider =
                  Provider.of<InternetConnectionProvider>(context);
              if (!internetConnectionProvider.isConnected) {
                return AlertDialog(
                  title: const Text('No Internet Connection'),
                  content: const Text(
                      'Please check your internet connection and try again.'),
                  actions: [
                    TextButton(
                      onPressed: () =>
                          internetConnectionProvider.checkInternetConnection(),
                      child: const Text('Retry'),
                    ),
                  ],
                );
              }
              return Container(
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          return snapshot.data!.fold((l) {
                            showErrorDialog(context, "errorMessage");
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomChip(
                            text: "Browse",
                            selected: isBrowseSelected,
                            onSelect: (value) {
                              setState(() {
                                isBrowseSelected = value;
                                isJobsSelected = false;
                                isResumeSelected = false;
                                isSettingsSelected = false;
                                currentIndex = 0;
                              });
                            }),
                        CustomChip(
                            text: "Your Jobs",
                            selected: isJobsSelected,
                            onSelect: (value) {
                              setState(() {
                                isJobsSelected = value;
                                isBrowseSelected = false;
                                isResumeSelected = false;
                                isSettingsSelected = false;
                                currentIndex = 1;
                              });
                            }),
                        CustomChip(
                            text: "Resume",
                            selected: isResumeSelected,
                            onSelect: (value) {
                              setState(() {
                                isResumeSelected = value;
                                isJobsSelected = false;
                                isBrowseSelected = false;
                                isSettingsSelected = false;
                                currentIndex = 2;
                              });
                            }),
                        CustomChip(
                            text: "Settings",
                            selected: isSettingsSelected,
                            onSelect: (value) {
                              setState(() {
                                isSettingsSelected = value;
                                isJobsSelected = false;
                                isResumeSelected = false;
                                isBrowseSelected = false;
                                currentIndex = 3;
                              });
                            }),
                      ],
                    ),
                    childsList[currentIndex],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

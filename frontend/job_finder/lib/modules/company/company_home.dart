import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_finder/global/config/local_storage.dart';
import 'package:job_finder/global/models/job.dart';
import 'package:job_finder/modules/home/controllers/job_controller.dart';
import 'package:job_finder/modules/home/controllers/user_controller.dart';
import '../../global/models/user.dart';
import '../../global/widgets/custom_app_bar.dart';
import '../../global/widgets/dialog.dart';

class CompanyHome extends StatefulWidget {
  const CompanyHome({super.key});

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
  static const String id = 'CompanyHome';
}

class _CompanyHomeState extends State<CompanyHome> {
  String userID = "";
  Timer? timer;
  final PageController _pageController = PageController();
  bool isListeningToStream = false;
  List<Job> _jobs = [];
  final _formKey = GlobalKey<FormState>();
  JobController _jobController = JobController();
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 5),
        (Timer t) => UserController.fetchUserData());

    LocalStrorageConfig.getUserData().then((value) {
      setState(() {
        userID = value!.userId!;
      });
    });
    _jobController = JobController();

    if (!isListeningToStream) {
      timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
        _jobController.fetchAllJobs();
      });
    }
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
              PageView(
                controller: _pageController,
                children: [
                  StreamBuilder<dynamic>(
                    stream: _jobController.jobsDataStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: MediaQuery.sizeOf(context).height * .6,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return snapshot.data!.fold((l) {
                          showErrorDialog(context, l);
                          return const Placeholder();
                        }, (jobs) {
                          _jobs = jobs;
                          return Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: _jobs.length,
                              itemBuilder: (context, index) {
                                final Job job = _jobs[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const SizedBox()));
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff00ABC8),
                                          Color.fromRGBO(32, 97, 219, 0.5),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const FlutterLogo(),
                                            Text(job.title!),
                                            RichText(
                                              text: TextSpan(
                                                text: DateFormat('dd/MM/yy')
                                                    .format(DateTime.parse(
                                                        job.startDate!)),
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                  fontSize: 10.0,
                                                  fontFamily: 'Lexend',
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                        "-${DateFormat('dd/MM/yy').format(DateTime.parse(job.endDate!))}",
                                                    style: const TextStyle(
                                                      fontSize: 10.0,
                                                      fontFamily: 'Lexend',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 50,
                                          decoration: const BoxDecoration(
                                            color: Color(0xff2061DB),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          margin: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10,
                                          ),
                                          child: Center(
                                            child: Text(
                                              job.description!,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(job.duration!),
                                            RichText(
                                              text: TextSpan(
                                                text: job.startTime!,
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                  fontSize: 10.0,
                                                  fontFamily: 'Lexend',
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: "-${job.endTime!}}",
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10.0,
                                                      fontFamily: 'Lexend',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text("${job.price!} DT")
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                            ),
                          );
                        });
                      } else {
                        return const Text('No data available');
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

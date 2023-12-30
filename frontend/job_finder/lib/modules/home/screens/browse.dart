import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_finder/global/config/constants.dart';
import 'package:job_finder/global/models/job.dart';
import 'package:job_finder/global/widgets/custom_chip.dart';
import 'package:job_finder/global/widgets/dialog.dart';
import 'package:job_finder/modules/home/screens/job_details.dart';
import '../controllers/job_controller.dart';

class Browse extends StatefulWidget {
  final String userId;
  const Browse({Key? key, required this.userId}) : super(key: key);

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  int selectedCity = 0;
  Timer? timer;
  bool isListeningToStream = false;
  List<Job> jobsList = [];
  JobController _jobController = JobController();
  @override
  void initState() {
    selectedCity = 0;
    _jobController = JobController();

    if (!isListeningToStream) {
      timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
        _jobController.fetchAllJobs();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.78,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: const TextSpan(
                    text: "Let's find you",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 25.0,
                      fontFamily: 'Lexend',
                    ),
                    children: <TextSpan>[
                      TextSpan(text: '\n'),
                      TextSpan(
                        text: "an opportunity here",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontFamily: 'Lexend',
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search, color: Colors.black, size: 40),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: AppConstants.tunisianCities.length,
              itemBuilder: (context, index) => CustomChip(
                text: AppConstants.tunisianCities[index],
                selected: index == selectedCity,
                onSelect: (val) {
                  setState(() {
                    selectedCity = index;
                  });
                },
              ),
            ),
          ),
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
                  jobsList = jobs;
                  if (selectedCity > 0) {
                    jobsList = jobsList
                        .where((element) => element.address!.contains(
                            AppConstants.tunisianCities[selectedCity]))
                        .toList();
                  }
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height *.78,
                    width: MediaQuery.sizeOf(context).width,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: jobsList.length,
                      itemBuilder: (context, index) {
                        final Job job = jobsList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JobDetails(
                                          jobID: job.sId!,
                                          userID: "",
                                        )));
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
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const FlutterLogo(),
                                    Text(job.title!),
                                    RichText(
                                      text: TextSpan(
                                        text: DateFormat('dd/MM/yy').format(
                                            DateTime.parse(job.startDate!)),
                                        style: const TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
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
                                  // padding:
                                  // const EdgeInsets.symmetric(horizontal: 10),
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
                                          color: Color.fromRGBO(0, 0, 0, 1),
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
                        height: MediaQuery.of(context).size.height * 0.05,
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
      ),
    );
  }
}

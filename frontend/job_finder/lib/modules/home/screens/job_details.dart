import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_finder/global/widgets/custom_chip.dart';
import 'package:job_finder/global/widgets/error_dialog.dart';
import 'package:job_finder/modules/home/controllers/application_controller.dart';
import 'package:job_finder/modules/home/controllers/job_controller.dart';

import '../../../global/models/job.dart';

class JobDetails extends StatefulWidget {
  final String jobID;
  final String userID;
  const JobDetails({
    super.key,
    required this.jobID,
    required this.userID,
  });

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  final JobController _jobController = JobController();
  Job? job;
  late String error = "";
  bool isDataLoaded = false;
  final ApplicationController _applicationController = ApplicationController();
  bool applied = false;
  @override
  void initState() {
    _jobController.getJobByID(widget.jobID).then((value) {
      value.fold((msg) {
        setState(() {
          isDataLoaded = true;
          error = msg;
        });
      }, (jobRes) {
        setState(() {
          job = jobRes;
          if (jobRes.applicantsIds!.contains(widget.userID)) {
            applied = true;
          }
          isDataLoaded = true;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.sizeOf(context).height *.9,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    "Job Details",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_outline,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              job == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      height: MediaQuery.sizeOf(context).height * .8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (applied)
                            const Text(
                              "You have already applied",
                              style: TextStyle(color: Colors.white),
                            ),
                          ListTile(
                            title: Text(
                              job!.title!,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 28),
                            ),
                            subtitle: Text(job!.entrepriseId!,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 20)),
                          ),
                          const FlutterLogo(
                            size: 85,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.width * .25,
                                width: MediaQuery.of(context).size.width * .25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(DateFormat('dd/MM/yy').format(
                                        DateTime.parse(job!.startDate!))),
                                    const Text('To'),
                                    Text(DateFormat('dd/MM/yy')
                                        .format(DateTime.parse(job!.endDate!))),
                                  ],
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.width * .25,
                                width: MediaQuery.of(context).size.width * .25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(job!.startTime!),
                                    const Text("To"),
                                    Text(job!.endTime!),
                                  ],
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.width * .25,
                                width: MediaQuery.of(context).size.width * .25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("${job!.price!}"),
                                    const Text("DT/h"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          CustomChip(
                            text: "Description",
                            selected: true,
                            onSelect: (p0) {},
                          ),
                          Text(
                            job!.description!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        bottomSheet: Container(
          height: MediaQuery.sizeOf(context).height * .05,
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: applied
                    ? null
                    : () {
                        _applicationController
                            .applyForJob(
                          jobId: job!.sId!,
                          comId: job!.entrepriseId!,
                        )
                            .then((value) {
                          if (value == "Success") {
                            setState(() {
                              applied = true;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Your application was sent successfully!'), // Message to display
                              ),
                            );
                          } else {
                            showErrorDialog(context, value);
                          }
                        });
                      },
                child: const Text(
                  "Apply",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const VerticalDivider(
                color: Colors.white70,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

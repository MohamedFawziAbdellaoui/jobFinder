import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_finder/modules/home/controllers/resume_controller.dart';
import '../../../global/models/resume.dart';
import '../../../global/widgets/dialog.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  Timer? timer;
  bool isListeningToStream = false;
  final ResumeController _resumeController = ResumeController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isFormEditable = false;
  @override
  void initState() {
    if (!isListeningToStream) {
      timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
        _resumeController.fetchResumeByUserID();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.81,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              const Text("Resume"),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
            ],
          ),
          StreamBuilder<dynamic>(
            stream: _resumeController.resumeDataStream,
            builder: (context, snapshot) {
              Widget builtWidget = const SizedBox();
              if (snapshot.connectionState == ConnectionState.waiting) {
                builtWidget = SizedBox(
                    height: MediaQuery.sizeOf(context).height * .9,
                    child: const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    )));
              } else if (snapshot.hasError) {
                builtWidget = Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                snapshot.data!.fold((l) {
                  showErrorDialog(context, l);
                  builtWidget = const Placeholder();
                }, (resume) {
                  Resume cv = resume;
                  builtWidget = SizedBox(
                    height: MediaQuery.sizeOf(context).height * .9,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: _isFormEditable ? const Icon(Icons.done) : const Icon(Icons.edit),
                              onPressed: () {
                                setState(() {
                                  _isFormEditable = !_isFormEditable;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * .2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Education",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * .001,
                                ),
                                Column(
                                  children: cv.education!.map((educationItem) {
                                    return Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                .8,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              textBaseline:
                                                  TextBaseline.ideographic,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                    "${educationItem.graduationYear}"),
                                                SizedBox(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          .1,
                                                ),
                                                Text("${educationItem.degree}")
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child:
                                                Text(educationItem.schoolName!),
                                          ),
                                          cv.education!
                                                      .indexOf(educationItem) !=
                                                  (cv.education!.length - 1)
                                              ? const Divider(
                                                  color: Colors.white,
                                                  thickness: 1.5,
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Experience",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * .02,
                                ),
                                Column(
                                  children: cv.workExperience!.map((workItem) {
                                    return Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: DateFormat('dd/MM/yy')
                                                        .format(DateTime.parse(
                                                            workItem
                                                                .startDate!)),
                                                    style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontSize: 10.0,
                                                      fontFamily: 'Lexend',
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            "-${DateFormat('dd/MM/yy').format(DateTime.parse(workItem.endDate!))}",
                                                        style: const TextStyle(
                                                          fontSize: 10.0,
                                                          fontFamily: 'Lexend',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Text(workItem.company!),
                                              Text(workItem.jobTitle!),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              workItem.description!,
                                              softWrap: true,
                                            ),
                                          ),
                                          cv.workExperience!
                                                      .indexOf(workItem) !=
                                                  (cv.workExperience!.length -
                                                      1)
                                              ? const Divider(
                                                  color: Colors.white,
                                                  thickness: 1.5,
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Skills",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: cv.skills!.map((skill) {
                                      return SizedBox(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(skill.name!),
                                                Text(skill.proficiency!)
                                              ],
                                            ),
                                            cv.skills!.indexOf(skill) !=
                                                    (cv.skills!.length - 1)
                                                ? const Divider(
                                                    color: Colors.white,
                                                    thickness: 1.5,
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      );
                                    }).toList()),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Certifications",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: cv.certifications!.map((certif) {
                                      return SizedBox(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(certif.name!),
                                                Text(DateFormat('dd/MM/yy')
                                                    .format(DateTime.parse(
                                                        certif.date!)))
                                              ],
                                            ),
                                            cv.certifications!
                                                        .indexOf(certif) !=
                                                    (cv.certifications!.length -
                                                        1)
                                                ? const Divider(
                                                    color: Colors.white,
                                                    thickness: 1.5,
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      );
                                    }).toList()),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Languages",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: cv.languages!.map((lang) {
                                      return SizedBox(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(lang.name!),
                                                Text(lang.proficiency!)
                                              ],
                                            ),
                                            cv.languages!.indexOf(lang) !=
                                                    (cv.languages!.length - 1)
                                                ? const Divider(
                                                    color: Colors.white,
                                                    thickness: 1.5,
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      );
                                    }).toList()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              } else {
                builtWidget = const Text('No data available');
              }
              return builtWidget;
            },
          ),
        ],
      ),
    );
  }
}

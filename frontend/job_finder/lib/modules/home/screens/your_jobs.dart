import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_finder/global/models/application.dart';
import 'package:job_finder/modules/home/controllers/application_controller.dart';
import '../../../global/widgets/dialog.dart';

class YourJobs extends StatefulWidget {
  const YourJobs({super.key});

  @override
  State<YourJobs> createState() => _YourJobsState();
}

class _YourJobsState extends State<YourJobs> {
  Timer? timer;
  final ApplicationController _applicationController = ApplicationController();

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      _applicationController.fetchAllAppsByUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.78,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: StreamBuilder<dynamic>(
        stream: _applicationController.appliactionsDataStream,
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
            }, (apps) {
              List<Application> _appsList = apps;
              builtWidget = Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _appsList.length,
                  itemBuilder: (context, index) {
                    final Application app = _appsList[index];
                    return Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff00ABC8),
                            Color.fromRGBO(32, 97, 219, 0.5),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const FlutterLogo(),
                              Text(app.job!.title!),
                              RichText(
                                text: TextSpan(
                                  text: DateFormat('dd/MM/yy').format(
                                      DateTime.parse(app.job!.startDate!)),
                                  style: const TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontSize: 10.0,
                                    fontFamily: 'Lexend',
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          "-${DateFormat('dd/MM/yy').format(DateTime.parse(app.job!.endDate!))}",
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: 10,
                              bottom: 10,
                            ),
                            child: Center(
                              child: Text(
                                app.job!.description!,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(app.job!.duration!),
                              RichText(
                                text: TextSpan(
                                  text: app.job!.startTime!,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontSize: 10.0,
                                    fontFamily: 'Lexend',
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "-${app.job!.endTime!}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10.0,
                                        fontFamily: 'Lexend',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text("${app.job!.price!} DT")
                            ],
                          )
                        ],
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
            builtWidget = const Text('No data available');
          }
          return builtWidget;
        },
      ),
    );
  }
}

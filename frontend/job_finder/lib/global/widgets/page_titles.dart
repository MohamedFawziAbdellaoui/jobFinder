import 'package:flutter/material.dart';
import 'package:job_finder/global/widgets/custom_chip.dart';

class PageTitles extends StatefulWidget {
  const PageTitles({super.key});

  @override
  State<PageTitles> createState() => _PageTitlesState();
}

class _PageTitlesState extends State<PageTitles> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomChip(
          text: "Browse",
          selected: true,
          onSelect: (p0) {
            setState(() {
              p0 = !p0;
            });
          },
        ),
        CustomChip(
          text: "Jobs",
          selected: false,
          onSelect: (p0) {
            setState(() {
              p0 = !p0;
            });
          },
        ),
        CustomChip(
          text: "Career",
          selected: false,
          onSelect: (p0) {
            setState(() {
              p0 = !p0;
            });
          },
        ),
        CustomChip(
          text: "Resume",
          selected: false,
          onSelect: (p0) {
            setState(() {
              p0 = !p0;
            });
          },
        ),
      ],
    );
  }
}

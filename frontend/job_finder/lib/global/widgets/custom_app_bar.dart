import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  String userName;
  CustomAppBar({super.key,required this.userName});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          child: Image.asset("assets/images/Ellipse.png"),
        ),
        Text(
          widget.userName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none_outlined,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:job_finder/global/models/user.dart';
import 'package:job_finder/global/widgets/custom_text_field.dart';
import 'package:job_finder/modules/home/controllers/user_controller.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Timer? timer;
  late User user;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      UserController.fetchUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .8,
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  )),
            ),
            CustomTextFormField(
              hintText: "Your name",
              labelText: "name",
              icon: Icons.person,
              onSaved: (val) {},
              validate: (val) {},
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            CustomTextFormField(
              hintText: "Email",
              labelText: "Email",
              icon: Icons.email,
              onSaved: (val) {},
              validate: (val) {},
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            CustomTextFormField(
              hintText: "Phone",
              labelText: "Phone",
              icon: Icons.phone,
              onSaved: (val) {},
              validate: (val) {},
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            CustomTextFormField(
              hintText: "Address",
              labelText: "Address",
              icon: Icons.location_on,
              onSaved: (val) {},
              validate: (val) {},
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            CustomTextFormField(
              hintText: "city",
              labelText: "City",
              icon: Icons.location_city,
              onSaved: (val) {},
              validate: (val) {},
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            CustomTextFormField(
              hintText: "Your name",
              labelText: "labelText",
              icon: Icons.person,
              onSaved: (val) {},
              validate: (val) {},
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            CustomTextFormField(
              hintText: "Your name",
              labelText: "labelText",
              icon: Icons.person,
              onSaved: (val) {},
              validate: (val) {},
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            CustomTextFormField(
              hintText: "Your name",
              labelText: "labelText",
              icon: Icons.person,
              onSaved: (val) {},
              validate: (val) {},
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            CustomTextFormField(
              hintText: "Your name",
              labelText: "labelText",
              icon: Icons.person,
              onSaved: (val) {},
              validate: (val) {},
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            CustomTextFormField(
              hintText: "Your name",
              labelText: "labelText",
              icon: Icons.person,
              onSaved: (val) {},
              validate: (val) {},
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            CustomTextFormField(
              hintText: "Your name",
              labelText: "labelText",
              icon: Icons.person,
              onSaved: (val) {},
              validate: (val) {},
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
          ],
        ),
      ),
    );
  }
}

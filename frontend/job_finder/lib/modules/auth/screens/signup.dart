import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/global/config/local_storage.dart';
import 'package:job_finder/global/models/resume.dart';
import 'package:job_finder/global/models/user.dart';
import 'package:job_finder/global/widgets/error_dialog.dart';
import 'package:job_finder/modules/auth/controllers/auth_controller.dart';
import 'package:job_finder/modules/auth/screens/login.dart';
import 'package:job_finder/modules/company/company_home.dart';
import 'package:job_finder/modules/home/home.dart';
import '../../../global/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
  static const String id = "Signup";
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = "";
  String userPass = "";
  String userCity = "";
  String userAddress = "";
  String userPhone = '';
  String userIdentity = '';
  String userCountry = '';
  String postalCode = '';
  String userType = "Employee";
  bool isbtnSubmitted = false;
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
          child: Form(
            key: _formKey,
            child: SizedBox(
              // height: MediaQuery.sizeOf(context).height * .2,
              width: MediaQuery.sizeOf(context).width,
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .2,
                  ),
                  const FlutterLogo(
                    size: 50,
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .1,
                  ),
                  CustomTextFormField(
                    hintText: "Full Name",
                    labelText: "Full Name",
                    icon: Icons.person,
                    onSaved: (value) {
                      userName = value;
                    },
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "The Name is required";
                      } else if (value.length < 5) {
                        return "Enter a valid Name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .05,
                  ),
                  CustomTextFormField(
                    hintText: "example@email.com",
                    labelText: "Email",
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) {
                      userEmail = value;
                    },
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "The email is required";
                      } else if (value.length < 8 &&
                          !value.contains(RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          ))) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .05,
                  ),
                  CustomTextFormField(
                    hintText: "**********",
                    labelText: "Password",
                    icon: Icons.lock,
                    obscure: true,
                    onSaved: (value) {
                      userPass = value;
                    },
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "The password is required";
                      } else if (value.length < 8 &&
                          !value.contains(RegExp(
                            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}$',
                          ))) {
                        return 'Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, one digit, and one special character (!@#\$%^&*()_+)';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .05,
                  ),
                  CustomTextFormField(
                    hintText: "route Gremda, ",
                    labelText: "Address",
                    icon: Icons.home,
                    onSaved: (value) {
                      userAddress = value;
                    },
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "The adresse is required";
                      } else if (value.length > 30 &&
                          !value.contains(RegExp(
                            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}$',
                          ))) {
                        return 'Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, one digit, and one special character (!@#\$%^&*()_+)';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .05,
                  ),
                  CustomTextFormField(
                    hintText: "11 222 333",
                    labelText: "Phone Number",
                    icon: Icons.phone,
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      userPhone = value;
                    },
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "The phone number is required";
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return "Enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .05,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Pick your avatar"),
                          Icon(Icons.cloud_upload_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .05,
                  ),
                  CustomTextFormField(
                    hintText: "Cin or passport",
                    labelText: "Cin or passport",
                    icon: Icons.home,
                    onSaved: (value) {
                      userIdentity = value;
                    },
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "The CIN is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .05,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Pick your IdentityPic"),
                          Icon(Icons.cloud_upload_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .05,
                  ),
                  CustomTextFormField(
                    hintText: "Country",
                    labelText: "Country",
                    icon: Icons.home,
                    onSaved: (value) {},
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "The adresse is required";
                      } else if (value.length > 30 &&
                          !value.contains(RegExp(
                            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}$',
                          ))) {
                        return 'Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, one digit, and one special character (!@#\$%^&*()_+)';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .05,
                  ),
                  Row(
                    children: [
                      CustomTextFormField(
                        hintText: "City",
                        labelText: "City",
                        icon: Icons.home,
                        onSaved: (value) {},
                        validate: (value) {},
                        width: MediaQuery.sizeOf(context).width * .3,
                      ),
                      CustomTextFormField(
                        hintText: "Postal Code",
                        labelText: "Postal Code",
                        icon: Icons.home,
                        onSaved: (value) {},
                        width: MediaQuery.sizeOf(context).width * .3,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "The postal code is required";
                          } else if (value.length > 30 &&
                              !value.contains(RegExp(
                                r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}$',
                              ))) {
                            return 'postal code must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, one digit, and one special character (!@#\$%^&*()_+)';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .05,
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      "Type : ",
                      style: TextStyle(
                        color: Colors.grey[850],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .5,
                          child: RadioListTile(
                            title: const Text('Employee'),
                            value: "Employee",
                            groupValue: userType,
                            onChanged: (value) {
                              setState(() {
                                userType = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .5,
                          child: RadioListTile(
                            title: const Text('Enterprise'),
                            value: "Entreprise",
                            groupValue: userType,
                            onChanged: (value) {
                              setState(() {
                                userType = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .05,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 40,
                    child: TextButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(4.0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff189C77),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                25.0), // Set the border radius
                          ),
                        ),
                      ),
                      onPressed: !isbtnSubmitted
                          ? () async {
                              setState(() {
                                isbtnSubmitted = !isbtnSubmitted;
                              });
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                
                                User newUser = User(
                                  name: userName,
                                  address: userAddress,
                                  country: "Tunisia",
                                  city: "Sfax",
                                  email: userEmail,
                                  identityPic: "",
                                  avatar: "",
                                  phoneNumber: userPhone,
                                  type: userType,
                                  cinOrPassport: userIdentity,
                                  password: userPass,
                                  postalCode: "3021",
                                );
                                final result =
                                    await AuthController.signUpUser(newUser,Resume());
                                result.fold(
                                  (error) {
                                    showErrorDialog(context, error);
                                  },
                                  (loginResponse) async {
                                    await LocalStrorageConfig.saveUserData(
                                        loginResponse);
                                    if(userType == "Employee"){
                                      Navigator.of(context)
                                        .pushNamed(HomePage.id);
                                    }else {
                                      Navigator.of(context)
                                        .pushNamed(CompanyHome.id);
                                    }
                                  },
                                );
                              }
                            }
                          : () {
                              setState(() {
                                isbtnSubmitted = !isbtnSubmitted;
                              });
                            },
                      child: isbtnSubmitted
                          ? const Icon(
                              Icons.pending,
                              color: Colors.white,
                            )
                          : const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .05,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "You already have an account? ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Login",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                              },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

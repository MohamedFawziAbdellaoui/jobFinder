import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/global/config/local_storage.dart';
import 'package:job_finder/global/widgets/error_dialog.dart';
import 'package:job_finder/modules/auth/controllers/auth_controller.dart';
import 'package:job_finder/modules/auth/screens/login.dart';
import 'package:job_finder/modules/home/home.dart';
import '../../../global/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
  static const String id = "login";
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userType = "Employee";
  String useremail = "";
  String userpass = "";
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
            child: Center(
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  const FlutterLogo(),
                  CustomTextFormField(
                    hintText: "Name and last name",
                    labelText: "Full Name",
                    icon: Icons.person,
                    onSaved: (value) {
                      useremail = value;
                    },
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "The Name is required";
                      } else if (value.length < 8 &&
                          !value.contains(RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          ))) {
                        return "Enter a valid Name";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    hintText: "example@email.com",
                    labelText: "Email",
                    icon: Icons.email,
                    onSaved: (value) {
                      useremail = value;
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
                  CustomTextFormField(
                    hintText: "**********",
                    labelText: "Password",
                    icon: Icons.lock,
                    obscure: true,
                    onSaved: (value) {
                      userpass = value;
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
                  CustomTextFormField(
                    hintText: "sfax gremda klm 4.5..",
                    labelText: "Adresse",
                    icon: Icons.home,
                    onSaved: (value) {
                      userpass = value;
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
                  CustomTextFormField(
                    hintText: "11 222 333",
                    labelText: "Phone Number",
                    icon: Icons.phone,
                    onSaved: (value) {
                      userpass = value;
                    },
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "The phone number is required";
                      } else if (value.length > 30 &&
                          !value.contains(RegExp(
                            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}$',
                          ))) {
                        return 'Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, one digit, and one special character (!@#\$%^&*()_+)';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    hintText: "Avatar",
                    labelText: "avatar",
                    icon: Icons.home,
                    onSaved: (value) {
                      userpass = value;
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
                  CustomTextFormField(
                    hintText: "Cin or passport",
                    labelText: "Cin or passport",
                    icon: Icons.home,
                    onSaved: (value) {
                      userpass = value;
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
                  CustomTextFormField(
                    hintText: "Identity Pic",
                    labelText: "Identity Pic",
                    icon: Icons.home,
                    onSaved: (value) {
                      userpass = value;
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
                  CustomTextFormField(
                    hintText: "address",
                    labelText: "address",
                    icon: Icons.home,
                    onSaved: (value) {
                      userpass = value;
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
                  CustomTextFormField(
                    hintText: "Country",
                    labelText: "Country",
                    icon: Icons.home,
                    onSaved: (value) {
                      userpass = value;
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
                  CustomTextFormField(
                    hintText: "City",
                    labelText: "City",
                    icon: Icons.home,
                    onSaved: (value) {
                      userpass = value;
                    },
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "The city is required";
                      } else if (value.length > 30 &&
                          !value.contains(RegExp(
                            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}$',
                          ))) {
                        return 'City must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, one digit, and one special character (!@#\$%^&*()_+)';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    hintText: "Postal Code",
                    labelText: "Postal Code",
                    icon: Icons.home,
                    onSaved: (value) {
                      userpass = value;
                    },
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Type : ",
                            style: TextStyle(color: Colors.grey[850])),
                        RadioListTile(
                          title: const Text('Employee'),
                          value: "Employee",
                          groupValue: userType,
                          onChanged: (value) {},
                        ),
                        RadioListTile(
                          title: const Text('Enterprise'),
                          value: "Employee",
                          groupValue: userType,
                          onChanged: (value) {},
                        ),
                      ]),
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
                                final result = await AuthController.loginUser(
                                    useremail, userpass);
                                result.fold(
                                  (error) {
                                    showErrorDialog(context, error);
                                  },
                                  (loginResponse) async {
                                    await LocalStrorageConfig.saveUserData(
                                        loginResponse);
                                    Navigator.of(context)
                                        .pushNamed(HomePage.id);
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
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    ),
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

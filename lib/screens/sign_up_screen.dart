import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_task3/app_colors.dart';
import 'package:ecommerce_task3/app_components.dart';
import 'package:ecommerce_task3/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> signUp({
    required String email,
    required String pass,
    required String username,
    String? phone,
  }) async {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try {
         FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass)
            .then(
          (value) {
            if (value.user != null) {
              saveUserData(
                username,
                email,
                pass,
                value.user!.uid,
              ).then(
                (value) {
                  if (value) {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false,
                    );
                  }
                },
              );
            }
          },
        );
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }

  Future<bool> saveUserData(
    String username,
    String email,
    String pass,
    String uid,
  ) async {
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).set({
        'userName': username,
        'userEmail': email,
        'userPass': pass,
        'uid': uid,
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppComponents.borderedContainer(
                  widget: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.navyBlue,
                  ),
                  widthPercent: 0.1,
                  heightPercent: 0.05,
                  context: context,
                  funOnTap: () {
                    Navigator.pop(context);
                  }),
              AppComponents.titleText(
                  text: "Welcome back! Glad\nto see you, Again!",
                  size: 28,
                  align: TextAlign.start),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Form(
                      child: AppComponents.customFormField(
                        context: context,
                        fieldController: usernameController,
                        hint: "Username",
                        validatorString: (String val) {
                          if (val.length < 4) {
                            return "username must have more than 4 characters";
                          }
                        },
                      ),
                    ),
                    Form(
                      child: AppComponents.customFormField(
                        context: context,
                        fieldController: emailController,
                        hint: "Email",
                        validatorString: (String val) {
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)) {
                            return "Please enter your email correctly";
                          }
                        },
                      ),
                    ),
                    Form(
                      child: AppComponents.customFormField(
                        context: context,
                        fieldController: passwordController,
                        hint: "Password",
                        validatorString: (String val) {
                          if (val.length < 9) {
                            return "Passwords must have at least 9 characters";
                          }
                        },
                      ),
                    ),
                    Form(
                        child: AppComponents.customFormField(
                            context: context,
                            fieldController: confirmPasswordController,
                            hint: "Confirm password",
                            validatorString: (String val) {
                              if (val != passwordController.value) {
                                return "Password should match the previous password";
                              }
                            })),
                  ],
                ),
              ),
              AppComponents.solidButton(
                  fun: () {
                    signUp(
                        email: emailController.text,
                        pass: passwordController.text,
                        username: usernameController.text);
                  },
                  widget: Text(
                    "Sign up",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  context: context),
              AppComponents.textBetweenDiv(widget: Text("Or Sign up with")),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppComponents.borderedContainer(
                      widget: Icon(
                        Icons.facebook,
                        color: Colors.blueAccent,
                      ),
                      widthPercent: 0.25,
                      heightPercent: 0.08,
                      context: context),
                  AppComponents.borderedContainer(
                      widget: Icon(
                        Icons.g_mobiledata_rounded,
                        color: Colors.red,
                        size: 40,
                      ),
                      widthPercent: 0.25,
                      heightPercent: 0.08,
                      context: context),
                  AppComponents.borderedContainer(
                      widget: Icon(
                        Icons.apple_sharp,
                        color: Colors.black,
                      ),
                      widthPercent: 0.25,
                      heightPercent: 0.08,
                      context: context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

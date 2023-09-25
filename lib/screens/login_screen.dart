import 'package:ecommerce_task3/app_colors.dart';
import 'package:ecommerce_task3/screens/home_screen.dart';
import 'package:ecommerce_task3/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app_components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  Future<void> login({
    required String email,
    required String pass,
  }) async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pass)
            .then(
          (value) {
            if (value.user != null) {
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
      } on FirebaseException catch (e) {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: MediaQuery.of(context).size.height * 0.05),
              AppComponents.titleText(
                  text: "Welcome back! Glad\nto see you, Again!",
                  size: 28,
                  align: TextAlign.start),
              Form(
                key: formKey,
                child: Column(
                  children: [
                     AppComponents.customFormField(
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
                    AppComponents.customFormField(
                        context: context,
                        fieldController: passwordController,
                        hint: "Password",
                        validatorString: (String val) {
                          if (val.length < 9) {
                            return "Passwords must have at least 9 characters";
                          }
                        },
                      ),
                  ],
                ),
              ),
              isLoading?Center(child: CircularProgressIndicator()):AppComponents.solidButton(
                  fun: () {
                    login(
                      email: emailController.text,
                      pass: passwordController.text,
                    );
                  },
                  widget: Text(
                    "Login",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>SignupScreen(),),(route) => false,);},
                    child: Text.rich(
                      TextSpan(
                        text: 'Don\'t have an account?',
                        children: <InlineSpan>[
                          TextSpan(
                            text: ' Register now',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.red),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

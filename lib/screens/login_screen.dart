import 'package:todo_app/main.dart';
import 'package:todo_app/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void openSignupScreen() {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const SignupScreen()));
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(223, 242, 255, 233),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            //scrolling
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  const SizedBox(height: 20),
                  //Title
                  Text(
                    'تسجيل الدخول',
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  //sub title
                  Text(
                    '!مرحبا بعودتك',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  //user name or Email
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الرجاء إدخال بريدك الإلكتروني ";
                      }

                      return null;
                    },
                    controller: emailcontroller,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 25),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 221, 15, 15))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 221, 15, 15))),
                        hintText: "البريد الإلكتروني"),
                  ),
                  const SizedBox(height: 10),
                  //password

                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الرجاء إدخال كلمة المرور";
                      }

                      return null;
                    },
                    controller: passwordcontroller,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 25),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 221, 15, 15))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 221, 15, 15))),
                        hintText: " كلمة المرور"),
                  ),

                  const SizedBox(height: 12),
                  //sign in button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text)
                                .then((userCredential) {
                              if (userCredential.user != null) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const ScreenRouter()),
                                    (route) => false);
                              }
                            });
                          } on FirebaseAuthException catch (e) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.message.toString())));
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 52, 38, 255),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                            child: Text(
                          'تسجيل الدخول',
                          style: GoogleFonts.robotoCondensed(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //text: sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: openSignupScreen,
                        child: Text(
                          'سجل الان',
                          style: GoogleFonts.robotoCondensed(
                              color: const Color.fromARGB(255, 5, 9, 253),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'لا يوجد لديك حساب؟',
                        style: GoogleFonts.robotoCondensed(
                            fontWeight: FontWeight.bold),
                      ),
                    ],
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

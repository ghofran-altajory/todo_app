import 'package:todo_app/main.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

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
                    'التسجيل ',
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  //sub title
                  Text(
                    'مرحبا!هنا بإمكانك التسجيل',
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
                            borderSide: BorderSide(color: Colors.blue)),
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
                            borderSide: BorderSide(color: Colors.blue)),
                        hintText: " كلمة المرور"),
                  ),

                  const SizedBox(height: 10),
                  //confim password
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الرجاء تأكيد كلمة المرور";
                      }

                      if (value != passwordcontroller.text) {
                        return "كلمات المرور غير متطابقة";
                      }

                      return null;
                    },
                    controller: confirmpasswordcontroller,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 25),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 221, 15, 15))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        hintText: "تأكيد كلمة المرور"),
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
                                .createUserWithEmailAndPassword(
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
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                            child: Text(
                          'التسجيل ',
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
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: Text(
                          'سجل دخولك ',
                          style: GoogleFonts.robotoCondensed(
                              color: const Color.fromARGB(255, 18, 62, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'لديك حساب دخولك هنا؟',
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

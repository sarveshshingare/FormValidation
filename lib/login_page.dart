// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/Auth/validate.dart';

import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//text controllers
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool emailError = false;
  bool passwordError = false;
  bool isVisible = false;

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _passwordcontroller.text.trim());
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.wechat_outlined,
                size: 100,
              ),
              SizedBox(
                height: 40,
              ),
              //Hello again !
              Text(
                'Hello again!',
                style: GoogleFonts.bebasNeue(fontSize: 54),
              ),
              SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'welcome back, you\'ve been missed',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 50,
              ),

              //email textfeild
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                          color: _emailcontroller.text.isEmpty
                              ? Colors.white
                              : isEmailValid
                                  ? Colors.green
                                  : Colors.red),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.isEmpty) {
                          isEmailValid = true;
                        } else {
                          final isValid = validateEmailAddress(value);
                          if (isValid) {
                            setState(() {
                              isEmailValid = true;
                              emailError = false;
                            });
                          } else {
                            setState(() {
                              isEmailValid = false;
                              emailError = true;
                            });
                          }
                        }
                      },
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                          errorText: !emailError
                              ? null
                              : "Enter correct email address !\n",
                          border: InputBorder.none,
                          hintText: "Email",
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 0.0),
                            child: Icon(Icons.mail),
                          )),
                    ),
                  ),
                ),
              ),

              //password textfeild
              SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                          color: _passwordcontroller.text.isEmpty
                              ? Colors.white
                              : isPasswordValid
                                  ? Colors.green
                                  : Colors.red),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.isEmpty) {
                          isPasswordValid = true;
                        } else {
                          final isValid = validatePass(value);
                          if (isValid) {
                            setState(() {
                              isPasswordValid = true;
                              passwordError = false;
                            });
                          } else {
                            setState(() {
                              isPasswordValid = false;
                              passwordError = true;
                            });
                          }
                        }
                      },
                      controller: _passwordcontroller,
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                          errorText: !passwordError
                              ? null
                              : "Atleast 8 character\nAtleast 1 number\n",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: isVisible
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),
                          prefixIcon: Icon(
                            Icons.password,
                          ),
                          border: InputBorder.none,
                          hintText: "Password"),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 15,
              ),

              //signin button

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: GestureDetector(
                  onTap: signIn,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Text(
                      "Sign In",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                  ),
                ),
              ),

              SizedBox(
                height: 25,
              ),

              //not a member?register now

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Text(
                      " Register Now",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

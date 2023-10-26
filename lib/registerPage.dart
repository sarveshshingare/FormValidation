// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/Auth/validate.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailcontroller = TextEditingController();

  final _namecontroller = TextEditingController();
  final _mobilecontroller = TextEditingController();

  final _passwordcontroller = TextEditingController();
  final _confirmPasswordcontroller = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isnamelValid = false;
  bool isMobileValid = false;

  bool emailError = false;
  bool passwordError = false;
  bool nameError = false;
  bool mobileError = false;

  bool isVisible = false;
  bool ispassword8char = false;
  bool hasPass1number = false;

  onPasswordchange(String password) {
    final numericRegex = RegExp(r'[0-9]');
    setState(() {
      ispassword8char = false;
      if (password.length >= 8) {
        ispassword8char = true;
        hasPass1number = false;
        if (numericRegex.hasMatch(password)) {
          hasPass1number = true;
        }
      }
    });
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordconfirm()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _passwordcontroller.text.trim(),
      );
    }
  }

  bool passwordconfirm() {
    if (_passwordcontroller.text.trim() ==
        _confirmPasswordcontroller.text.trim()) {
      return true;
    } else {
      return false;
    }
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
                'Hello there!',
                style: GoogleFonts.bebasNeue(fontSize: 54),
              ),
              SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Register below with your details',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 50,
              ),
// name textfield

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                          color: _namecontroller.text.isEmpty
                              ? Colors.white
                              : isnamelValid
                                  ? Colors.green
                                  : Colors.red),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.isEmpty) {
                          isnamelValid = true;
                        } else {
                          final isValid = validateName(value);
                          if (isValid) {
                            setState(() {
                              isnamelValid = true;
                              nameError = false;
                            });
                          } else {
                            setState(() {
                              isnamelValid = false;
                              nameError = true;
                            });
                          }
                        }
                      },
                      controller: _namecontroller,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          errorText:
                              !nameError ? null : "Enter correct name !\n",
                          border: InputBorder.none,
                          hintText: "Full Name"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              // mobile textfield

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                          color: _mobilecontroller.text.isEmpty
                              ? Colors.white
                              : isMobileValid
                                  ? Colors.green
                                  : Colors.red),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.isEmpty) {
                          isMobileValid = true;
                        } else {
                          final isValid = validateMobile(value);
                          if (isValid) {
                            setState(() {
                              isMobileValid = true;
                              mobileError = false;
                            });
                          } else {
                            setState(() {
                              isMobileValid = false;
                              mobileError = true;
                            });
                          }
                        }
                      },
                      controller: _mobilecontroller,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                          ),
                          errorText:
                              !mobileError ? null : "Enter correct mobile number !\n",
                          border: InputBorder.none,
                          hintText: "Mobile no."),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
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
                          prefixIcon: Icon(
                            Icons.mail,
                          ),
                          errorText: !emailError
                              ? null
                              : "Enter correct email address !\n",
                          border: InputBorder.none,
                          hintText: "Email"),
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
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      onChanged: (password) => onPasswordchange(password),
                      controller: _passwordcontroller,
                      obscureText: !isVisible,
                      decoration: InputDecoration(
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
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),

                      width: 20,

                      height: 20,

                      decoration: BoxDecoration(
                          color: ispassword8char
                              ? Colors.green
                              : Colors.transparent,
                          border: ispassword8char
                              ? Border.all(color: Colors.transparent)
                              : Border.all(color: Colors.grey.shade400),
                          borderRadius:
                              BorderRadius.circular(50)), // BoxDecoration

                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ), // AnimatedContainer

                    SizedBox(
                      width: 10,
                    ),

                    Text("Contains at least 8 characters"),
                  ],
                ),
              ), // Row
              SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),

                      width: 20,

                      height: 20,

                      decoration: BoxDecoration(
                          color: hasPass1number
                              ? Colors.green
                              : Colors.transparent,
                          border: ispassword8char
                              ? Border.all(color: Colors.transparent)
                              : Border.all(color: Colors.grey.shade400),
                          borderRadius:
                              BorderRadius.circular(50)), // BoxDecoration

                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ), // AnimatedContainer

                    SizedBox(
                      width: 10,
                    ),

                    Text("Contains at least 1 number"),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ), // Row

              SizedBox(
                height: 10,
              ),
              //comfirm password textfeild
              SizedBox(
                width: 50,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: _confirmPasswordcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.password,
                          ),
                          border: InputBorder.none,
                          hintText: "Confirm Password"),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              //signin button

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: GestureDetector(
                  onTap: signUp,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Text(
                      "Sign Up",
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
                    "I am a member?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Text(
                      " Login Now",
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

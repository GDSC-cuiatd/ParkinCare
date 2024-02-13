import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myworking_app/Screens/Auth/forgeotPassword.dart';
import 'package:myworking_app/Screens/Auth/signup.dart';

import 'package:myworking_app/homeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key
  final formKey = GlobalKey<FormState>();
  bool obscurePassword = false;
  //editing controllers
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  //firebase auth
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your email address.";
        }
        if (!RegExp(r'^[a-zA-Z0-9.-]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
            .hasMatch(value)) {
          return "Enter a valid Email.";
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Enter Email",
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //pass field
    final passField = TextFormField(
      autofocus: false,
      obscureText: obscurePassword,
      controller: passwordController,
      validator: (value) {
        RegExp regExp = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return "Password is required for logning";
        }
        if (!regExp.hasMatch(value)) {
          return "Password must contain minmum 6 charectors";
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
            child: Icon(
              obscurePassword ? Icons.visibility_off : Icons.visibility,
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Enter Password",
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      textInputAction: TextInputAction.done,
    );

    //button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFF009DD1),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signing(emailController.text, passwordController.text);
        },
        child: Text(
          "Login",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
      ),
    );

    var h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "lib/Assets/disability.png",
                        fit: BoxFit.contain,
                        height: h * 0.20,
                      ),
                      SizedBox(
                        height: h * 0.12,
                      ),
                      emailField,
                      SizedBox(
                        height: MediaQuery.of(context).size.width * .06,
                      ),
                      passField,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPassword()));
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * .12,
                      ),
                      loginButton,
                      SizedBox(
                        height: h * .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()),
                              );
                            },
                            child: Text(
                              "Sign Up ",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ),
        )),
      ),
    );
  }

  void signing(String email, String password) async {
    try {
      if (formKey.currentState!.validate()) {
        await auth.signInWithEmailAndPassword(email: email, password: password);

        // If sign-in is successful
        Fluttertoast.showToast(msg: "Login Successfully");

        // Introduce a delay before navigating to the next screen
        await Future.delayed(Duration(seconds: 2));

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => homepage()),
        );
      }
    } catch (e) {
      // Handle errors during sign-in
      String errorMessage = "An error occurred during login";
      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? "An unknown error occurred";
      }

      Fluttertoast.showToast(msg: errorMessage);
    }
  }
}

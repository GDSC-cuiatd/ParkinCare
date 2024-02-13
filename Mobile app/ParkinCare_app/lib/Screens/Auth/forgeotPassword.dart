import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myworking_app/Screens/Auth/login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final auth = FirebaseAuth.instance;
  //form key
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //confirmation button
    final EmailButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFF009DD1),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          EmailFunction(emailController.text);
        },
        child: Text(
          "Confirm Email",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
      ),
    );
    var h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: h * 0.14,
                ),
                Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Enter the Email Address ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Associated with your account.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                emailField,
                SizedBox(
                  height: h * 0.03,
                ),
                EmailButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void EmailFunction(String email) {
    auth.sendPasswordResetEmail(email: email).then((value) {
      Fluttertoast.showToast(
          msg: "We have sent an email to recover the password.");
    }).catchError((error) {
      Fluttertoast.showToast(msg: "Error: ${error.toString()}");
    });
  }
}

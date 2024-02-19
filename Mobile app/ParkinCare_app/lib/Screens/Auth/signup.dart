import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myworking_app/Models/User_model.dart';
import 'package:myworking_app/Screens/Auth/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //auth
  final auth = FirebaseAuth.instance;
  //form key
  final formKey = GlobalKey<FormState>();
  //editing controllers
  final TextEditingController UserNameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmpasswordController =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    //user name
    final usernameField = TextFormField(
      autofocus: false,
      controller: UserNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regExp = new RegExp(r'^.{5,}$');
        if (value!.isEmpty) {
          return "Enter user name";
        }
        if (!regExp.hasMatch(value)) {
          return "Name must contain minmum 6 charectors";
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          labelText: "Enter User Name",
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          //hintText: "Enter User Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //mail
    final EmailField = TextFormField(
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
    //password
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      keyboardType: TextInputType.text,
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
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Enter Password",
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //confirm password
    final confirmpasswordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: confirmpasswordController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (confirmpasswordController.text.length > 6 &&
            passwordController.text != value) {
          return "Password do not match";
        }

        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Confirm password",
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //button
    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFF193660),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailController.text, passwordController.text);
        },
        child: Text(
          "Sign Up",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
      ),
    );

    var h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: (Scaffold(
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
                        "lib/Assets/logo.png",
                        fit: BoxFit.contain,
                        height: h * 0.30,
                      ),
                      SizedBox(
                        height: h * 0.07,
                      ),
                      usernameField,
                      SizedBox(
                        height: MediaQuery.of(context).size.width * .05,
                      ),
                      EmailField,
                      SizedBox(
                        height: MediaQuery.of(context).size.width * .05,
                      ),
                      passwordField,
                      SizedBox(
                        height: MediaQuery.of(context).size.width * .05,
                      ),
                      confirmpasswordField,
                      SizedBox(
                        height: MediaQuery.of(context).size.width * .07,
                      ),
                      signupButton
                    ],
                  )),
            ),
          ),
        )),
      )),
    );
  }

  void signUp(String email, String password) async {
    if (formKey.currentState!.validate()) {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFireStore()})
          .catchError((error) {
        Fluttertoast.showToast(msg: "Error: ${error.toString()}");
        throw error;
      });
    }
  }

  //firestore Setting
  Future postDetailsToFireStore() async {
//firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;
    //userModel
    UserModel userModel = UserModel();

    //Setting values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.Name = UserNameController.text;

    await firestore.collection("user").doc(user.uid).set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created Sucessfully");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/app_state/app_state.dart';
import 'package:notes_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnlineSyncScreen extends StatefulWidget {
  @override
  _OnlineSyncScreenState createState() => _OnlineSyncScreenState();
}

class _OnlineSyncScreenState extends State<OnlineSyncScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final SharedPreferences prefs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<kLoginCodesEnum> loginUser() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      // User created and logged in. Handle online data management.

      prefs = await SharedPreferences.getInstance();
      prefs.setString(kEmailKeySharedPreferences, emailController.text);

      migrateToNewCollection();

      return kLoginCodesEnum.successful;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return kLoginCodesEnum.weak_password;
      } else if (e.code == 'email-already-in-use') {
        // Account exists. Just login
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

          prefs = await SharedPreferences.getInstance();
          prefs.setString(kEmailKeySharedPreferences, emailController.text);

          migrateToNewCollection();

          return kLoginCodesEnum.successful;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            return kLoginCodesEnum.wrong_password;
          } else {
            print("Some issue while logging in");
            return kLoginCodesEnum.unknownError;
          }
        }
      } else {
        print("Some issue while registration");
        return kLoginCodesEnum.unknownError;
      }
    }
  }

  void migrateToNewCollection() {
    CollectionReference old =
        FirebaseFirestore.instance.collection(kDefaultEmail);

    CollectionReference notes = FirebaseFirestore.instance
        .collection(prefs.getString(kEmailKeySharedPreferences)!);

    old.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((oldDoc) {
        print('Moving doc: ${oldDoc.id} to new Collection');
        notes.doc(oldDoc.id).set(oldDoc.data()!);
        oldDoc.reference.delete();
      });
    });

    FirebaseFirestore.instance.enableNetwork();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kDarkThemeBackgroundColor,
        ),
        body: Center(
          child: Container(
            height: 400,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Go online!".toUpperCase(),
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.1),
                  ),
                  SizedBox(height: 10),
                  Text(
                      'Enter an email-password combination to allow for online syncing. This will allow you to access your notes when you switch devices.'),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration:
                        kInputFieldDecoration.copyWith(labelText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      value = value!.toLowerCase().trim();
                      if (value.isEmpty) {
                        return "Please enter your email id.";
                      }
                      if (value == kDefaultEmail) {
                        return "This email is invalid.";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "This does not seem to be a valid email id";
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: passwordController,
                    style: TextStyle(fontSize: 18),
                    decoration:
                        kInputFieldDecoration.copyWith(labelText: "Password"),
                    // keyboardType: TextInputType.o,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the password.";
                      } else if (value.length < 6) {
                        return "Please enter at least 6 characters for the password.";
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF5C49E0)),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print("Valid data entered for login.");
                        Provider.of<AppState>(context, listen: false)
                            .loginUser(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) {
                          if (value == kLoginCodesEnum.unknownError) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("An unknown error occurred.")));
                          } else if (value == kLoginCodesEnum.wrong_password) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Wrong password entered.")));
                          } else if (value == kLoginCodesEnum.weak_password) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Firebase says it is a weak password.")));
                          } else if (value == kLoginCodesEnum.successful) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Logged in successfully.")));
                            Navigator.of(context).pop();
                          }
                        });
                      }
                    },
                    child: Text(
                      "Sync Now",
                      style: TextStyle(fontSize: 18, letterSpacing: 0.75),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

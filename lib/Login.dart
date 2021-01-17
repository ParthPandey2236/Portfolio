import 'package:flutter/material.dart';
import 'package:profile_testing/Profile.dart';
import 'package:profile_testing/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
String Email="";
class _LoginState extends State<Login> {
  String Password="";
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 150,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (text){
                      Email=text;
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder:  UnderlineInputBorder(
                        borderSide:  BorderSide(
                          color: Colors.white,
                        )
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                           color: Colors.white,
                        ),
                      ),

                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (text){
                      Password=text;
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder:  UnderlineInputBorder(
                          borderSide:  BorderSide(
                            color: Colors.white,
                          )
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),

                    ),
                    ),
                ),

                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height/20.36,
                    width: MediaQuery.of(context).size.height/1.95,
                    alignment: Alignment.center,
                    color: Colors.blue,
                    child: FlatButton(
                        height: MediaQuery.of(context).size.height/20.36,
                        minWidth: MediaQuery.of(context).size.height/1.95,
                        onPressed: () async{
                          try {
                            UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: Email,
                                password: Password
                            );
                            Email=Email.substring(0,Email.indexOf('@'));
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>Profile()));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              AlertDialog(
                                title: Text('No user found for that email.'),
                              );
                            } else  {
                              AlertDialog(
                                title: Text('Wrong password provided for that user.'),
                              );
                            }
                         }

                        },
                        child: Text('Login',style: TextStyle(color: Colors.white),)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height/20.36,
                    width: MediaQuery.of(context).size.height/1.95,
                    alignment: Alignment.center,
                    color: Colors.blue,
                    child: FlatButton(
                        height: MediaQuery.of(context).size.height/20.36,
                        minWidth: MediaQuery.of(context).size.height/1.95,
                        onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUp()));
                        },
                        child: Text('Sign Up',style: TextStyle(color: Colors.white))),

                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}


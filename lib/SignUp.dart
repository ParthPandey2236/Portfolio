import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login.dart';
FirebaseAuth auth = FirebaseAuth.instance;
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController Email=new TextEditingController();
  TextEditingController Password = new TextEditingController();
  TextEditingController Name=new TextEditingController();
  TextEditingController PhoneNo = new TextEditingController();
  TextEditingController RegNo = new TextEditingController();
  TextEditingController CollegeID = new TextEditingController();
  TextEditingController Year = new TextEditingController();
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
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextField(
                      controller: Email,
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
                    padding: const EdgeInsets.all(4.0),
                    child: TextField(
                      controller: Password,
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
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextField(
                      controller: Name,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Name",
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
                    padding: const EdgeInsets.all(4.0),
                    child: TextField(
                      controller: PhoneNo,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "PhoneNo",
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
                    padding: const EdgeInsets.all(4.0),
                    child: TextField(
                      controller: CollegeID,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "College Name",
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
                      padding: const EdgeInsets.all(4.0),
                      child: TextField(
                        controller: Year,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Year",
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
                    padding: const EdgeInsets.all(4.0),
                    child: TextField(
                      controller: RegNo,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Registration No.",
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
                      color: Colors.blue,
                      height: MediaQuery.of(context).size.height/20.36,
                      width: MediaQuery.of(context).size.height/1.95,
                      child: FlatButton(
                          height: MediaQuery.of(context).size.height/20.36,
                          minWidth: MediaQuery.of(context).size.height/1.95,
                        child: Text('Signup',style: TextStyle(color: Colors.white),),
                        onPressed: () async {
                          try {
                            String email1=Email.text.toString();
                            FirebaseFirestore.instance.collection('PersonalDetails').doc(email1.substring(0,email1.indexOf('@'))).set({
                              'Name': Name.text.toString(),
                               'PhoneNo' : PhoneNo.text.toString(),
                               'EmailID' : Email.text.toString(),
                                'CollegeID' : CollegeID.text.toString(),
                                'RegNo' : RegNo.text.toString(),
                                'Year' : Year.text.toString(),
                            }).then((value)=>print('user value added'))
                                .catchError((error)=> print('Failed to add User value'));
                            final newUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: Email.text.toString(),
                                password: Password.text.toString());
                            if (newUser != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Login()));
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
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
                            Navigator.push(context,MaterialPageRoute(builder:(context)=>Login()));
                          },
                          child: Text('Login',style: TextStyle(color: Colors.white))),
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


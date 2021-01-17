import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'Login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image;
  final picker=ImagePicker();
  String Name="fdsdf",PhoneNo="sfdsf",CollegeID="sdfsf",RegNo="fsfdf",EmailID="fsdfs",Year="fsdf";
  String CircleAvtarImage=null;
  CollectionReference UserRefrance = FirebaseFirestore.instance.collection('ProfilePicUrl');
  CollectionReference DetailsRefrence= FirebaseFirestore.instance.collection('PersonalDetails');
  Future<void> AddToFirestore(var url){
     return UserRefrance.doc(Email).set({
       'URL' : url,
     }).then((value)=>print('user added'))
         .catchError((error)=> print('Failed to add User'));
  }

  Future<firebase_storage.UploadTask> uploadFile(BuildContext context) async{
     String fileName=path.basename(_image.path);
     firebase_storage.Reference ref= firebase_storage.FirebaseStorage.instance.ref().child(Email).child(fileName);
     firebase_storage.UploadTask uploadTask = ref.putFile(_image);
     final url1=await (await uploadTask).ref.getDownloadURL();
     //print(url1.toString());
     setState(() {
       CircleAvtarImage =url1.toString();
       AddToFirestore(url1);
     });
  }

  Future<void> getImageViaGallery() async{
    Navigator.pop(context);
    final pickedFile =await picker.getImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      final croppedFile=await ImageCropper.cropImage(
        sourcePath: File(pickedFile.path).path,
      );
      setState(() {
        if(croppedFile!=null){
          _image=File(croppedFile.path);
          uploadFile(context);

        }else{
          print('No file selected');
        }
      });
    }
  }

  Future<void> getImageViaCamera() async{
    Navigator.pop(context);
    final pickedFile =await picker.getImage(source: ImageSource.camera);
    if(pickedFile!=null){
      final croppedFile=await ImageCropper.cropImage(
          sourcePath: File(pickedFile.path).path,
      );
      setState(() {
        if(croppedFile!=null){

          _image=File(croppedFile.path);
          uploadFile(context);


        }else{
          print('No file selected');
        }
      });
    }
    else{
      print('No file selected');
    }
  }

 String setImage(){
    String mainLink=null;
        UserRefrance.doc(Email)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          var link=documentSnapshot.data()['URL'];
          print(link);
          setState(() {
            CircleAvtarImage=link.toString();
          });
        //  CircleAvtarImage=link.toString();
          print(CircleAvtarImage);
        }
        else {
          print('unsucsessful');
        }});
     DetailsRefrence.doc(Email).get().then((DocumentSnapshot documentSnapshot){
       if(documentSnapshot.exists){

            var Name1= documentSnapshot.data()['Name'];
           var PhoneNo1 = documentSnapshot.data()['PhoneNo'];
           var CollegeID1= documentSnapshot.data()['CollegeID'];
           var RegNo1 = documentSnapshot.data()['RegNo'];
           var EmailID1 =documentSnapshot.data()['EmailID'];
           var Year1= documentSnapshot.data()['Year'];
           setState(() {
             Name=Name1;
             PhoneNo=PhoneNo1;
             CollegeID=CollegeID1;
             RegNo=RegNo1;
             EmailID=EmailID1;
             Year=Year1;
           });

       }
    });


  }


 void displayBottomSheet(){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          color: Colors.black,
          height: 150,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)
              )
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text('Camera'),
                  onTap: getImageViaCamera,
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Gallery'),
                  onTap: getImageViaGallery,
                )
              ],

            ),
          ),
        );
      }
    );
 }
 @override
  void initState() {
    setImage();
    setState(() {});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(

            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 50.0,
                      backgroundImage: CircleAvtarImage==null?AssetImage('images/profile.png'):NetworkImage(CircleAvtarImage),
                  ),
                  RaisedButton(
                    child: Icon(Icons.add_a_photo),
                    onPressed: displayBottomSheet,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/10.4,),
                  Text('Name :  ${Name}',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height/33.6),),
                  SizedBox(height: MediaQuery.of(context).size.height/22.4,),
                  Text('Email ID:  ${EmailID}',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height/33.6)),
                  SizedBox(height: MediaQuery.of(context).size.height/22.4,),
                  Text('RegNo : ${RegNo}',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height/33.6)),
                  SizedBox(height: MediaQuery.of(context).size.height/22.4,),
                  Text('PhoneNo : ${PhoneNo}',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height/33.6)),
                  SizedBox(height: MediaQuery.of(context).size.height/22.4,),
                  Text('College Name : ${CollegeID}',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height/33.6)),
                  SizedBox(height: MediaQuery.of(context).size.height/22.4,),
                  Text('Year : ${Year}',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height/33.6)),
                  SizedBox(height: MediaQuery.of(context).size.height/22.4,),
                  RaisedButton(
                      child: Icon(Icons.logout),
                      onPressed: () async{
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                      },
                    )
                ],
              ),
            ),
        ),

    );
  }
}

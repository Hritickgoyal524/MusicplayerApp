
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:toast/toast.dart';
class UploadingPage extends StatefulWidget {
 



  @override
  _UploadingPageState createState() => _UploadingPageState();
}

class _UploadingPageState extends State<UploadingPage> {
  TextEditingController songcontroller=TextEditingController();
  TextEditingController artistcontroller=TextEditingController();
  File image,song;
  String imagepath,songpath;
  Reference ref;
  var image_downl_url,song_downl_url;
  final firestorageinstance=FirebaseFirestore.instance;
  void selectimage()async{
image=await FilePicker.getFile();
setState(() {
  image=image;
  imagepath=basename(image.path);
  uploadimagefile(imagepath,image.readAsBytesSync());
});}
Future<String>uploadimagefile(String imagepath,List<int>image)async{
ref=FirebaseStorage.instance.ref().child(imagepath);
UploadTask uploadtask=ref.putData(image);
image_downl_url=await (await uploadtask.whenComplete(() => null)).ref.getDownloadURL();
}
finalupload(){
  var data={
    "songname":songcontroller.text,
    "artistname":artistcontroller.text,
    "songurl":song_downl_url.toString(),
    "imageurl":image_downl_url.toString()
  };
  firestorageinstance.collection("songs").doc().set(data);
}
void selectsong()async{
song=await FilePicker.getFile();
setState(() {
  song=song;
  songpath=basename(song.path);
  uploadsongfile(songpath,song.readAsBytesSync());
 
});}
Future<void>uploadsongfile(String songpath,List<int>song)async{
ref=FirebaseStorage.instance.ref().child(songpath);
UploadTask uploadtask=ref.putData(song);
song_downl_url=await (await uploadtask.whenComplete(() => null)).ref.getDownloadURL();
}
  
  Widget build(BuildContext context){
    return  SingleChildScrollView(child:Center(child:
      Column(children: [
        SizedBox(height:MediaQuery.of(context).size.height/6),
        RaisedButton(
          child:Text("Select Image"),
          onPressed:(){
selectimage();
 Toast.show("Image is uploaded",context,duration:Toast.LENGTH_LONG,gravity:Toast.BOTTOM, );
          }
        ),
        SizedBox(height:20),
        RaisedButton(child:Text("Select Song"),
        onPressed:(){
selectsong();
 Toast.show("Song is uploaded",context,duration:Toast.LENGTH_LONG,gravity:Toast.BOTTOM, );
        }),
         SizedBox(height:20),
      Container(
        margin: EdgeInsets.all(22),
        padding: EdgeInsets.all(10),
        child:  TextField(
          controller: songcontroller,
          autocorrect: true,decoration: InputDecoration(
          hintText: "Enter Song  name"
        ),)),
         SizedBox(height:20),
          Container(
        margin: EdgeInsets.all(22),
        padding: EdgeInsets.all(10),
        child:TextField(
           controller: artistcontroller,
           autocorrect: true,decoration: InputDecoration(
          hintText: "Enter artist  name"
        ),)),
         SizedBox(height:20),
        RaisedButton(
          child:Text("upload"),
          onPressed:(){
            Toast.show("Data is uploaded",context,duration:Toast.LENGTH_LONG,gravity:Toast.BOTTOM, );
            finalupload();
          }
        )
      ],)
      ));

    
  }}
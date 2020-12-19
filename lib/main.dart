import 'package:flutter/material.dart';
import 'package:musicplayer/screens/home.dart';
import 'package:musicplayer/screens/upload.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentindex=0;

  List tabs=[HomePage(),UploadingPage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
      appBar:AppBar(title: Text("Music player App",
      ),
      backgroundColor: Colors.grey,
      centerTitle: true,
      ),
      body:tabs[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        items: [
BottomNavigationBarItem(icon:Icon( Icons.home,),label:"Home" ),
BottomNavigationBarItem(icon:Icon( Icons.cloud_upload),label:"upload" ),
      ],
      
      onTap: (index){
        setState((){
          currentindex=index;
        });
        
      },),
    )

    );
  }
}


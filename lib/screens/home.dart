import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/screens/songpage.dart';
class HomePage extends StatefulWidget {
 



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<QuerySnapshot>qry;
  initState(){
    super.initState();
    getdata();
  }
   getdata()async{
  
      
  setState(() {
    
 
qry= FirebaseFirestore.instance.collection("songs").snapshots();
print(qry);
   });

  }
  Widget build(BuildContext context){
    return StreamBuilder(
      stream:qry,
      builder:(context,snapshot){
return snapshot.hasData?
 ListView.builder(
itemCount: snapshot.data.documents.length,
itemBuilder: (context,index){
 
 return InkWell(
    onTap:(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SongPage(songname:snapshot.data.documents[index].data()['songname'],
      artistname:snapshot.data.documents[index].data()['artistname'],
      song_url:snapshot.data.documents[index].data()['songurl'],
      image_url:snapshot.data.documents[index].data()["imageurl"]
      )));},
    child:Container(
      
      height: 70,
      child:Card(
     // leading: CircleAvatar(backgroundImage:NetworkImage(snapshot.data.documents[index].data()['imageurl'])),
       child:Container(
         padding: EdgeInsets.fromLTRB(6, 10, 5, 5),
         child: 
       Row(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
       CircleAvatar(backgroundImage: NetworkImage(snapshot.data.documents[index].data()['imageurl'],),),
       SizedBox(width:10),
       Text("Song name: "+ snapshot.data.documents[index].data()['songname']),
        SizedBox(width:10),
         Text("Artist :"+ snapshot.data.documents[index].data()['artistname'],textAlign: TextAlign.end),


      // trailing: Text(snapshot.data.documents[index].data()['artistame']), 
        ],)))
  ));
}
): Center(child:CircularProgressIndicator());
}
      
    
    );


  }
}
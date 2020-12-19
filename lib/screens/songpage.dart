import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_player/music_player.dart';
import 'package:toast/toast.dart';
class SongPage extends StatefulWidget {
 String songname;
 String image_url;
 String song_url;
 String artistname;
SongPage({this.artistname,this.image_url,this.song_url,this.songname});


  @override
  _SongPageState createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  MusicPlayer musicplayer;
  bool isplaying=false;
 void  initState(){
    super.initState();
    initPlateformState();
  }
  Future<void> initPlateformState() async{
musicplayer=MusicPlayer();
  }
Widget build(BuildContext context){
  return Scaffold(
    appBar:AppBar(title: Text("Music player "),
    backgroundColor: Colors.amberAccent,
    centerTitle: true,),
    body:Center(child:Column(
      children:[
        SizedBox(height: 50,),
        Card(
          child:Image.network(widget.image_url,height: 300,width: 300,fit: BoxFit.cover,)
        ),
        SizedBox(height:25),
        Text(widget.songname,style:TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.redAccent) ,),
        SizedBox(height:15),
        Text(widget.artistname,style:TextStyle(fontSize: 18,color: Colors.greenAccent) ,),
        SizedBox(height:40),
        Row(children: [
          SizedBox(width:50),
          Expanded(child:FlatButton(child: Icon(Icons.play_arrow,size: 50,),onPressed: (){
           setState(() {
            isplaying=true; 
            Toast.show("Song is playing",context,duration:Toast.LENGTH_LONG,gravity:Toast.BOTTOM, );
           }); 
        musicplayer.play(MusicItem(url: widget.song_url,
      albumName: "",
      trackName: "",
      artistName: "",
      coverUrl: "",
      duration: Duration(seconds:220)
      
        ));

          },),),
         
          Expanded(child:FlatButton(child: Icon(Icons.stop,
          size: 50,
          color: isplaying==true?Colors.black:Colors.red,),onPressed: (){
            setState(() {
              
           
            isplaying=false;
             });
            musicplayer.stop();
            Toast.show("Song is stop",context,duration:Toast.LENGTH_LONG,gravity:Toast.BOTTOM, );
          },),),
          SizedBox(width:50)
        ],)

      ]
    ) ,)
  );
}
}
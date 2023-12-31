import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class Home_Page extends StatefulWidget {

  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  List<Photos> photosList=[];
  Future<List<Photos>> getPhotos()async{
    final response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data= jsonDecode(response.body.toString());
    if(response.statusCode==200){
      photosList.clear();
      for(Map i in data){
        Photos photos=Photos(title: i['title'], url: i['url'],id:i['id']);
        photosList.add(photos);
      }
      return photosList;

    }
    else{
      return photosList;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Practise"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder:(context,AsyncSnapshot<List<Photos>>snapshot){
              return ListView.builder(
                itemCount: photosList.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      title: Text(snapshot.data![index].id.toString()),
                      subtitle: Text(snapshot.data![index].title.toString()),
                    );
                  });
            }),
          )

        ],
      ),
    );
  }
}

class Photos{
  String title , url;
  int id;
  Photos({required this.title,required this.url,required this.id}){

  }
}

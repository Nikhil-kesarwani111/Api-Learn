import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'PostsModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

List<PostsModel> postlist=[];//now this list is empty(we make this we dont have data in array)
  Future<List<PostsModel>>  getPosttApi () async{//we use array but we dont store data in array list
     var url =Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response= await http.get(url);//getting the url from server
        var data=jsonDecode(response.body.toString());//we store the body of reespose(url) in data variable
        if(response.statusCode==200)//check the status code is right or not
        {//now we store the data(every index) in array list
          postlist.clear();
          for(Map i in data)
          {
          postlist.add(PostsModel.fromJson(i));//now we ddded
          }
          return postlist;
        }
        else
          {
            return postlist;//Return blank array
          }
  }//Now future function is ready ,now create future builder to show text in phone
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Api'),
      backgroundColor: Colors.blue,),
      body: Column(
        children: [
          Expanded(
            //flex: 1,
            child: FutureBuilder(future: getPosttApi () , builder:(context,snapshot){//context means resent context
              if(snapshot.connectionState==ConnectionState.waiting)
                {
                  return CircularProgressIndicator();
                }
              else {
                 return ListView.builder(
                     itemCount: postlist.length,
                     itemBuilder: (context,index) {
                   return Card(
                     color: Colors.white,
                     // elevation: 12,
                     child:Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('Title\n'+postlist[index].title.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                           Text('Body\n'+ postlist[index].body.toString()),
                         ],
                       ),
                     ),
                   );
                 });


              }
            }),
          ),
        ],
      ),
      
    );
  }
}

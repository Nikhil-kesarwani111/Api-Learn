import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart'as http;

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  List<UserModel> userlist=[];

  Future<List<UserModel>> getUser()async{
    final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
        UserModel userModel=UserModel( username: i["username"],
        );
        userlist.add(userModel);
      }
      return userlist;
    }else
    {
      return userlist;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.grey,
        title:Text('Object in Object') ,),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(future: getUser(), builder:(context,snapshot){
              // if(snapshot.connectionState==ConnectionState.waiting)
              //   {
              //     return Text('Loading...');
              //   }
              // else if (snapshot.connectionState==ConnectionState.done)
              // {
              //     if(snapshot.hasError){
              //     return Text(snapshot.error.toString());
              //     }
              //     else if(snapshot.hasData){
              //     return Text(snapshot.data.toString());
              //     }
              //     else{
              //     return Text('Somthing went wrong');
              //     }
              // }
              // else{
              return ListView.builder(
                  itemCount: userlist.length,
                  itemBuilder:(context,index){
                    return Card(
                      child: Column(
                        children: [
ReusableRaw(title: 'Name',Type: userlist[index].username.toString(),)
                        ],
                      ),
                      elevation: 5,

                    );
                  });
            }
              // }
            ),
          )
        ],
      ),
    );
  }
}
class UserModel {

  String username;
  // int id;
  //Address address;
  // Company company;

  UserModel({
    //   required this.name,
    required this.username,
    //  required this.email,
    // required this.website,
    // required this.id,
  //  required this.address,
    // required this.company
  });
}
//
// class Address{
// //   String street,suite,city,zipcode;
//   Geo geo;
// //
//   Address({
// //     required this.street,
// //     required this.suite,
// //     required this.city,
// //     required this.zipcode,
//     required this.geo,
//   });
// }
// //
// class Geo{
//   String lat;
//   Geo({
//     required this.lat,
// //     required this.lng,
// //
//   });
// //
// }
// //
// // class Company{
// //   String name,catchPhrase,bs;
// //   Company({
// //     required this.name,
// //     required this.catchPhrase,
// //     required this.bs,
// // });
// // }


class ReusableRaw extends StatelessWidget {
  final String title,Type;
  const ReusableRaw({super.key, this.title='',this.Type=''});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(Type),
       Text(title),
      ],
    );
  }
}

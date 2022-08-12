import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 String data = '';
 late Map mapres;
 late List listres=[];

 Future apiCall () async {
   http.Response response;
   response = await http.get(Uri.parse("https://reqres.in/api/users?page=1"));

   if(response.statusCode==200){
     setState(() {
       mapres = jsonDecode(response.body);
       listres = mapres['data'];
     });
   }
 }

 // @override
 // void initState(){
 //   apiCall();
 //   super .initState();
 // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context,index){
        return Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(padding: const EdgeInsets.all(10),
                  child: Image.network(listres[index]['avatar'])
                  ),
                  Text(listres[index]['id'].toString()),
                  Column(
                    children: [
                      Text(listres[index]['first_name'].toString()),
                      Text(listres[index]['last_name'].toString()),
                      Text(listres[index]['email'].toString())
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
        itemCount: listres.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: apiCall,
        child: Text("Fetch data"),
      ),
    );
  }
}

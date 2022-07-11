// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Detail2.dart';
import 'loginform.dart';
import 'homepage2.dart';

class Home2 extends StatefulWidget {
  @override
  // final String text;
  // Home({Key key, @required this.text}) : super(key: key);
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home2> {
  Future<List> getData() async{
    final String url = "https://kelompok.kangoding.com/getdata.php";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "List Data Inventory",
          style: TextStyle(fontFamily: "Netflix"),
        ),
        backgroundColor: Colors.pink,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: "logout",
            onPressed: () {
              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (BuildContext context) => new HomePage2()));
              // logout(context);
            },
            // onPressed: () => Navigator.of(context).pushReplacement(
            //   new MaterialPageRoute(
            //       builder: (BuildContext context) => new AddData())),
            label: const Text('Menu'),
            icon: const Icon(Icons.logout),
            backgroundColor: Colors.blue,
          ),
          SizedBox(
            width: 20,
          ),
          //SizedBox(height: 10,),
          
        ],
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context,snapshot){
          if(snapshot.hasError) print(snapshot.error);
          

          return snapshot.hasData 
          ? new ItemList(list: snapshot.data,) 
          : new Center(
            child: new CircularProgressIndicator(),
          );
        },

      ),
    );
      // body: new FutureBuilder<List>(
      //   future: getData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) print('Errornya');print(snapshot.error);

      //     return snapshot.hasData
      //         ? new ItemList(
      //             list: snapshot.data,
      //           )
      //         : new Center(
      //             child: new CircularProgressIndicator(),
      //           );
      //   },
      // ),

  //     body: new FutureBuilder<List>(
  //       future: getData(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasError) print(snapshot.error);

  //         return snapshot.hasData
  //             ? new ItemList(
  //                 list: snapshot.data,
  //               )
  //             : new Center(
  //                 child: new CircularProgressIndicator(),
  //               );
  //       },
  //     ),
  //   );
  // }
  }
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () =>
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (BuildContext context) => new Detail2(
                          list: list,
                          index: i,
                        ))),
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['item_name'],
                  style: TextStyle(fontFamily: "Netflix"),
                ),
                leading: new Icon(Icons.widgets),
                subtitle: new Text("Stock : ${list[i]['stock']}"),
              ),
            ),
          ),
        );
      },
    );
  }

}


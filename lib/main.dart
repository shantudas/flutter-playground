import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_playground/User.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const String APP_DEBUG = "AppDebug";

  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Container(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: FutureBuilder(
          future: fetchUsersInfo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColorLight,
                )),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                // Let the ListView know how many items it needs to build.
                itemCount: snapshot.data.length,
                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.
                itemBuilder: (context, index) {
                  final item = snapshot.data[index];

                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.company.name),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  );
                },
              );
            } else {
              return Text("some thing went wrong ");
            }
          },
        )) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

Future<List<User>> fetchUsersInfo() async {
  final response = await get('https://jsonplaceholder.typicode.com/users');
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);

    List<User> users = [];
    for (var i in jsonData) {
      User user = User.fromJson(i);
      users.add(user);
    }
    print('AppDebug users length :: ${users.length}');

    return users;
  } else {
    throw Exception('Unable to fetch users from the REST API');
  }
}

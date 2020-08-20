import 'package:flutter/material.dart';
import 'package:flutter_playground/User.dart';
import 'package:flutter_playground/UserDetails.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        UserDetails.routeName: (context) => UserDetails(),
      },

      /*routes: <String, WidgetBuilder> {
        '/user-details': (BuildContext context) => UserDetails(),
      },*/

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
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
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
  final users = User.fetchAllUsers();

  @override
  Widget build(BuildContext context) {

    print('rebuilding');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) => _itemBuilder(users[index]),
      ),
    );
  }

  Widget  _itemBuilder(User user) {
    return ListTile(
      title: Text(user.fullName),
      subtitle: Text(user.company),
      onTap: () => _onPressed(user),
    );
  }

  _onPressed(User user) {
    //Navigator.pushNamed(context, '/user-details');
    Navigator.pushNamed(context, UserDetails.routeName, arguments: user);
  }
}

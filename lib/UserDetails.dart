import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/User.dart';

class UserDetails extends StatelessWidget {
  static const routeName = '/UserDetails';

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("User details"),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          ListTile(
            title: Text("User's full name"),
            subtitle: Text(user.name),
          ),
          ListTile(
            title: Text("User's name"),
            subtitle: Text(user.userName),
          ),
          ListTile(
            title: Text("User's company"),
            subtitle: Text(user.company.name),
          ),
          ListTile(
            title: Text("User's email"),
            subtitle: Text(user.email),
          ),
          ListTile(
            title: Text("User's address"),
            subtitle: Text('street: ${user.address.street}, ${user.address.suite}, city: ${user.address.city}, zip code: ${user.address.zipCode}'),
          ),
        ],
      )),
    );
  }
}

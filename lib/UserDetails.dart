import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'User.dart';

class UserDetails extends StatelessWidget {
  static const routeName = '/UserDetails';

  @override
  Widget build(BuildContext context) {
    final User args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text("User details")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Name: " + args.fullName),
          Text("User name: " + args.userName),
          Text("Company:" + args.company),
          Text("Address:" + args.address),
          Text("Phone: "+args.phone),
        ],
      )),
    );
  }
}

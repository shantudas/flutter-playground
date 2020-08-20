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
        children: <Widget>[
          Text(args.fullName)
        ],
      )),
    );
  }
}

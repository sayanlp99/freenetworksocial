import 'package:flutter/material.dart';

AppBar header(context) {
  return AppBar(
    title: Text(
      "FreeNetworkSocial",
      style: TextStyle(
        color: Colors.white,
        fontFamily: "Signatra",
        fontSize: 30.0,
      ),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}

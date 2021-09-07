import 'package:flutter/material.dart';

header(context) {
  return AppBar(
    title: Text(
      "FreeNetworkSocial",
      style: TextStyle(
          color: Colors.white, fontFamily: "Signatra", fontSize: 40.0),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}

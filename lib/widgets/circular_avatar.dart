import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularAvatar extends StatefulWidget {
  const CircularAvatar({Key? key}) : super(key: key);

  @override
  State<CircularAvatar> createState() => _CircularAvatarState();
}

class _CircularAvatarState extends State<CircularAvatar> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: AssetImage('images/person.jpg'),
    );
  }
}

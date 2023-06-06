import 'package:flutter/material.dart';

class AppMenuPopup extends StatelessWidget {
  const AppMenuPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(icon: Icon(Icons.more_horiz, color: Colors.white,),
      color: Colors.black45,
      itemBuilder: (context) =>
      [
        PopupMenuItem<int>(
            value: 0,
            child: Text("Setting", style: TextStyle(color: Colors.white),)
        ),
        PopupMenuItem<int>(
            value: 0,
            child: Text(
              "Clear All", style: TextStyle(color: Colors.white),)
        ),
      ],
      onSelected: (item) => {
        print(item)
      },
    );
  }
}

import 'package:flutter/material.dart';

class AppbarWidget extends StatefulWidget implements PreferredSizeWidget {
  final Widget title;
  AppbarWidget({this.title});
  @override
  _AppbarWidgetState createState() => _AppbarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppbarWidgetState extends State<AppbarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      //automaticallyImplyLeading: false,
      // leading: GestureDetector(
      //   onTap: () {/* Write listener code here */},
      //   child: Image.asset("assets/images/logo.jpg"),
      // ),
      backgroundColor: Colors.white, //Color.fromARGB(255, 240, 108, 155),
      title: Center(
        child: Text(
          "MMTweet",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}

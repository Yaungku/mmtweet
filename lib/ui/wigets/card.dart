import 'package:flutter/material.dart';
import 'package:mmtweet/ui/wigets/space.dart';

class PageCard extends StatelessWidget {
  final String pageTitle;
  final IconData iconData;
  final Function onTap;

  const PageCard(
      {Key key,
      @required this.pageTitle,
      @required this.iconData,
      @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Card(
        elevation: 0.0,
        // color: Theme.of(context).primaryColor,
        // margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              iconData,
              color: Theme.of(context).accentColor,
              size: 35.0,
            ),
            space10(),
            Center(
              child: Text(pageTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.black),
                  softWrap: true),
            )
          ],
        ),
      ),
    );
  }
}

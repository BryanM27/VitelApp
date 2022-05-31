import 'package:flutter/material.dart';

class TextBoldContainer extends StatelessWidget {
  final String? title;
  final String? info;
  const TextBoldContainer({
    Key? key,
    this.title,
    this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.only(top: 3),
              child: Row(children: [
                Text(
                  info!,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ]))
        ],
      ),
    );
  }
}

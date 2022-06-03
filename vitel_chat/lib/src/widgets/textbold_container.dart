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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title!,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          info!,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

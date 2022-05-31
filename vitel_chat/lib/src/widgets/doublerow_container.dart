import 'package:flutter/material.dart';

class TextDoubleRowContainer extends StatelessWidget {
  final String? title;
  final String? info;
  const TextDoubleRowContainer({
    Key? key,
    this.title,
    this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Row(children: <Widget>[
        Row(
          children: <Widget>[
            //Item 2/4
            Expanded(
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
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(30),
                color: Colors.blueAccent,
                child: const Center(
                  child: Text('ITEM2'),
                ),
              ),
            ),
          ],
        ),
      ]),
    ]));
  }
}

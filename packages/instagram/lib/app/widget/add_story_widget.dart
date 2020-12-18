import 'package:flutter/material.dart';

class AddStoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        color: Colors.transparent,
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                    child: Text(
                  "Eu",
                  style: TextStyle(
                      color: Color(0xffDA6ED0),
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ))),
            Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                top: 0,
                child: Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 30,
                      color: Color(0xffDA6ED0),
                    ),
                  ),
                )),
          ],
        ));
  }
}

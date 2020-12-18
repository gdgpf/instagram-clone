import 'package:flutter/material.dart';
import 'package:instagram/domain/model/profile.dart';

class StoreWidget extends StatelessWidget {
  final Profile profile;

  StoreWidget({@required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: 80,
      child: Stack(children: [
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
                child: Text(
              this.profile.username,
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Color(0xffDA6ED0),
              child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Container(
                      child: Card(
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    child: Image.network(
                      "http://192.168.1.133:3000/image/${profile.pathCode}",
                      fit: BoxFit.cover,
                    ),
                  ))),
            ))
      ]),
    );
  }
}

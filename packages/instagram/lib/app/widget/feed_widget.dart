import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram/data/constants.dart';
import 'package:instagram/domain/model/feed.dart';
import 'package:instagram/domain/model/profile.dart';

class FeedWidget extends StatelessWidget {
  final Feed feed;

  FeedWidget({@required this.feed});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Image.network(
                        "$url/image/${feed.profile.pathCode}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Text(
                    feed.profile.username,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )
                ],
              ),
              Icon(Icons.more_vert)
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          SizedBox(
            height: 350,
            width: double.infinity,
            child: Card(
              elevation: 10,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Image.network(
                "$url/image/${feed.image.pathCode}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.favorite_border,
                    // Icons.favorite,
                    // color: Colors.red,
                    size: 30,
                  ),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 30,
                  ),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Icon(
                    Icons.screen_rotation_outlined,
                    size: 30,
                  )
                ],
              ),
              Icon(
                Icons.inbox,
                size: 30,
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            feed.description,
          ),
          Divider()
        ],
      ),
    );
  }
}

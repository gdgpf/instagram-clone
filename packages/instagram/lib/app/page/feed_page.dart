import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:instagram/app/widget/add_story_widget.dart';
import 'package:instagram/app/widget/feed_widget.dart';
import 'package:instagram/app/widget/story_widget.dart';
import 'package:instagram/controller/login/login_controller.dart';
import 'package:instagram/controller/profile/profile_controller.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final profileController = ProfileController();

  @override
  void initState() {
    super.initState();
    profileController.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Container(
                height: 135,
                child: Observer(builder: (_) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return AddStoreWidget();
                      }

                      return StoreWidget(
                        profile: profileController.profiles[index - 1],
                      );
                    },
                    itemCount: profileController.profiles.length + 1,
                  );
                })),
            Divider(),
            Observer(builder: (_) {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return FeedWidget(feed: profileController.feed[index]);
                },
                itemCount: profileController.feed.length,
              );
            })
          ],
        ),
      ),
    );
  }
}

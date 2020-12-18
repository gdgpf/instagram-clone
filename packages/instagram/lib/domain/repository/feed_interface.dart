import 'package:instagram/domain/model/feed.dart';

abstract class FeedInterface {
  Future<List<Feed>> index();
  Future<bool> create();
}

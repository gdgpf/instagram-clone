import 'package:instagram/data/repository/feed_repository.dart';
import 'package:instagram/data/repository/profile_repository.dart';
import 'package:instagram/device/repository/profile_local_reposiitory.dart';
import 'package:instagram/domain/model/feed.dart';
import 'package:instagram/domain/repository/feed_interface.dart';

class FeedUseCase implements FeedInterface {
  @override
  Future<List<Feed>> index() async {
    try {
      final api = FeedRepository();

      List<Feed> feed = await api.index();

      return feed;
    } catch (e) {
      throw e;
    }
  }
}

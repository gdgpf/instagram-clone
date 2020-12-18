import 'package:instagram/data/constants.dart';
import 'package:instagram/domain/model/feed.dart';
import 'package:dio/dio.dart';

class FeedRepository {
  Future<List<Feed>> index() async {
    try {
      Dio dio = new Dio();

      Response response = await dio.get("$url/feed");

      return response.data.map<Feed>((feed) => Feed.fromJson(feed)).toList();
    } catch (e) {
      throw e;
    }
  }
}

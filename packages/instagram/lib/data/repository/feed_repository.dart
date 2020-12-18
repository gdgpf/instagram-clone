import 'package:instagram/data/constants.dart';
import 'package:instagram/domain/model/feed.dart';
import 'package:dio/dio.dart';
import 'package:instagram/domain/model/image.dart';
import 'package:instagram/domain/model/profile.dart';
import 'package:path/path.dart' as path;

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

  Future<String> getLoreInpsum() async {
    try {
      Dio dio = new Dio();

      Response response = await dio.get(
          "https://loripsum.net/api/1");

      return response.data;
    } catch (e) {
      print("aui");
      throw e;
    }
  }

  Future<Image> createImage(String imagePath, Profile profile) async {
    Dio dio = new Dio();
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(imagePath,
            filename: path.basename(imagePath))
      });

      print("$url/${profile.username}/image/post");
      Response response = await dio.post("$url/${profile.username}/image/post",
          data: formData,
          options: Options(method: 'POST', responseType: ResponseType.json));

          print(Image.fromJson(response.data));

      return Image.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }


  Future<Feed> create(Map<String, dynamic> payload) async {
    try {
      Dio dio = new Dio();

      print(payload);

      Response response = await dio.post("$url/feed", data: payload);

      return Feed.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }
}

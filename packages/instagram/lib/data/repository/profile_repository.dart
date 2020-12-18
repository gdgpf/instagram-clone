import 'package:instagram/data/constants.dart';
import 'package:instagram/domain/model/profile.dart';
import 'package:dio/dio.dart';

class ProfileRepository {
  Future<Profile> create(String username) async {
    try {
      Dio dio = new Dio();

      Response response =
          await dio.post("$url/profile", data: {"username": username});

      return Profile.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }

  Future<Profile> login(String username) async {
    try {
      Dio dio = new Dio();

      Response response = await dio.get("$url/profile/$username");

      return Profile.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }

  Future<List<Profile>> index() async {
    try {
      Dio dio = new Dio();

      Response response = await dio.get("$url/profile");

      return response.data
          .map<Profile>((profile) => Profile.fromJson(profile))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}

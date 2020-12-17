import 'package:instagram/data/constants.dart';
import 'package:instagram/domain/model/profile.dart';
import 'package:dio/dio.dart';

class ProfileRepository {
  Future<Profile> create(String username) async {
    try {
      Dio dio = new Dio();

      Response response =
          await dio.post("$url/kpi/cenario", data: {"username": username});

      return Profile.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }
}

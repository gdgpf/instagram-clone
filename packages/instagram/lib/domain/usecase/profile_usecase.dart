import 'package:instagram/data/repository/profile_repository.dart';
import 'package:instagram/device/repository/profile_local_reposiitory.dart';
import 'package:instagram/domain/model/profile.dart';
import 'package:instagram/domain/repository/profile_interface.dart';

class ProfileUseCase implements ProfileInterface {
  @override
  Future<Profile> create(String username) async {
    try {
      final api = ProfileRepository();
      final local = ProfileLocalRepository();

      Profile profile = await api.create(username);

      await local.delete();
      await local.create(profile);

      return profile;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Profile> login(String username) async {
    try {
      final api = ProfileRepository();
      final local = ProfileLocalRepository();

      Profile profile = await api.login(username);

      await local.delete();
      await local.create(profile);
      return profile;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<Profile>> index() async {
    try {
      final api = ProfileRepository();

      List<Profile> profiles = await api.index();

      return profiles;
    } catch (e) {
      throw e;
    }
  }
}

import 'package:instagram/data/repository/profile_repository.dart';
import 'package:instagram/domain/model/profile.dart';
import 'package:instagram/domain/repository/profile_interface.dart';

class ProfileUseCase implements ProfileInterface {
  @override
  Future<Profile> create(String username) async {
    try {
      final api = ProfileRepository();

      Profile profile = await api.create(username);

      return profile;
    } catch (e) {
      throw e;
    }
  }
}

import 'package:instagram/domain/model/profile.dart';

abstract class ProfileInterface {
  Future<Profile> create(String username);
  Future<Profile> login(String username);
  Future<List<Profile>> index();
}

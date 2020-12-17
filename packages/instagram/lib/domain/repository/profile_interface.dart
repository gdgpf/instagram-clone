import 'package:instagram/domain/model/profile.dart';

abstract class ProfileInterface {
  Future<Profile> create(String username);
}
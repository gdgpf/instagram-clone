import 'package:image_picker/image_picker.dart';
import 'package:instagram/data/repository/feed_repository.dart';
import 'package:instagram/device/repository/profile_local_reposiitory.dart';
import 'package:instagram/domain/model/feed.dart';
import 'package:instagram/domain/model/image.dart';
import 'package:instagram/domain/model/profile.dart';
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

  @override
  Future<bool> create() async {
    try {
      final picker = ImagePicker();

      final pickedFile = await picker.getImage(source: ImageSource.camera);

      final api = FeedRepository();
      final local = ProfileLocalRepository();

      String text = await api.getLoreInpsum();

      text = text.replaceAll("<p>", "").replaceAll("<\\p>", "");

      text = text.substring(0, text.length > 499 ? 499 : text.length - 1);

      Profile profile = await local.select();

      Image image = await api.createImage(pickedFile.path, profile);

      await api.create({
        "description": text,
        "profile": {"id": profile.id},
        "image": {"id": image.id}
      });

      return true;
    } catch (e) {
      throw e;
    }
  }
}

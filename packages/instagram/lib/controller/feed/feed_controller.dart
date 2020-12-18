import 'package:instagram/domain/model/feed.dart';
import 'package:instagram/domain/model/profile.dart';
import 'package:instagram/domain/usecase/feed_usecase.dart';
import 'package:instagram/domain/usecase/profile_usecase.dart';
import 'package:mobx/mobx.dart';
part 'feed_controller.g.dart';

class FeedController = _FeedControllerBase with _$FeedController;

abstract class _FeedControllerBase with Store {
  @observable
  ObservableList<Profile> _profiles = new ObservableList.of([]);

  @observable
  ObservableList<Feed> _feed = new ObservableList.of([]);

  @computed
  List<Profile> get profiles => _profiles.toList();

  @computed
  List<Feed> get feed => _feed.toList();

  @action
  initState() async {
    try {
      final profileUseCase = ProfileUseCase();
      final feedUseCase = FeedUseCase();
      this._profiles = ObservableList.of(await profileUseCase.index());

      this._feed = ObservableList.of(await feedUseCase.index());
    } catch (e) {
      print(e);
    }
  }

  @action
  create() async {
    try {
      final feedUseCase = FeedUseCase();
      await feedUseCase.create();
      this._feed = ObservableList.of(await feedUseCase.index());
    } catch (e) {
      print(e);
    }
  }
}

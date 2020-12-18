import 'package:instagram/domain/model/feed.dart';
import 'package:instagram/domain/model/profile.dart';
import 'package:instagram/domain/usecase/feed_usecase.dart';
import 'package:instagram/domain/usecase/profile_usecase.dart';
import 'package:mobx/mobx.dart';
part 'profile_controller.g.dart';

class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
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
      final apiProfile = ProfileUseCase();
      final apiFeed = FeedUseCase();
      this._profiles = ObservableList.of(await apiProfile.index());

      this._feed = ObservableList.of(await apiFeed.index());
    } catch (e) {}
  }
}

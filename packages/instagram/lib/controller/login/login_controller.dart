import 'package:flutter/widgets.dart';
import 'package:instagram/data/repository/profile_repository.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  @observable
  bool _loading = false;

  @computed
  bool get loading => this._loading;

  final username = TextEditingController();

  @action
  create() async {
    this._loading = true;
    final api = ProfileRepository();
    await api.create(username.text);
    this._loading = false;
  }
}
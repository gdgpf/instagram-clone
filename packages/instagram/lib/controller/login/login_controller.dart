import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram/app/page/feed_page.dart';
import 'package:instagram/domain/usecase/profile_usecase.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  bool _loading = false;

  @computed
  bool get loading => this._loading;

  final username = TextEditingController();

  @action
  create(BuildContext context) async {
    try {
      this._loading = true;
      final api = ProfileUseCase();
      await api.create(username.text);
      this._loading = false;
       Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => FeedPage()),
          (Route<dynamic> route) => false);
    } catch (e) {
      print(e);
    }
  }

  @action
  login(BuildContext context) async {
    try {
      this._loading = true;
      final api = ProfileUseCase();
      await api.login(username.text);
      this._loading = false;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => FeedPage()),
          (Route<dynamic> route) => false);
    } catch (e) {
      print(e);
    }
  }
}

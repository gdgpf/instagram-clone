import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:instagram/controller/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  final profileController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/instagram.png"),
            Padding(padding: EdgeInsets.all(8)),
            TextField(
              controller: profileController.username,
              decoration: InputDecoration(labelText: "Usuário"),
            ),
            Padding(padding: EdgeInsets.all(8)),
            Observer(builder: (_) {
              return SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: RaisedButton(
                      child: profileController.loading
                          ? CircularProgressIndicator()
                          : Text("Login"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () {
                        profileController.login(context);
                      }));
            }),
            Padding(padding: EdgeInsets.all(8)),
            SizedBox(
                height: 40,
                width: double.infinity,
                child: RaisedButton(
                    child: Text("Criar conta"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {
                      profileController.create(context);
                    }))
          ],
        ),
      ),
    );
  }
}

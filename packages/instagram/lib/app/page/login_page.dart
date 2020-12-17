import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
              decoration: InputDecoration(labelText: "Usuário"),
            ),
            Padding(padding: EdgeInsets.all(8)),
            SizedBox(
                height: 40,
                width: double.infinity,
                child: RaisedButton(
                    child: Text("Login"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {})),
            Padding(padding: EdgeInsets.all(8)),
            SizedBox(
                height: 40,
                width: double.infinity,
                child: RaisedButton(
                    child: Text("Criar conta"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {}))
          ],
        ),
      ),
    );
  }
}

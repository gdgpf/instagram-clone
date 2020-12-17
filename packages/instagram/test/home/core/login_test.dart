
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:instagram/app/page/login_page.dart';
import 'package:instagram/data/repository/profile_repository.dart';
import 'package:instagram/domain/model/profile.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements ProfileRepository {}

void main() {
  group('Login', () {
    testWidgets(
        'Deve chamar o controller e incrementar os dados que existem na tela',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginPage(),
      ));

      expect(find.byType(RaisedButton), findsNWidgets(2));
    });
  });

  test('Deve retornar um objeto do tipo Profile ao criar um profile novo', () async {
    final client = MockClient();

    when(client.create("vinicius")).thenAnswer((_) async => Profile(
      username: "vinicius"
    ));
  
    expect(await client.create("vinicius"), isA<Profile>());
  });
}

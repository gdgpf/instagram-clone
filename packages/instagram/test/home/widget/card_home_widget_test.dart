import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram/app/page/login_page.dart';

void main() {
  testWidgets('Deve constar três icones no card', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    expect(find.byType(Icon), findsNWidgets(3));
  });

  testWidgets('Deve constar 1 card', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    expect(find.byType(Card), findsNWidgets(1));
  });

  testWidgets("Deve trocar a cor do like quando for clicado",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));
    expect(
        (tester.widget(find.byType(Icon).at(0)) as Icon).color, Colors.black);

    await tester.tap(find.byType(Icon).at(0));
    await tester.pump();

    expect((tester.widget(find.byType(Icon).at(0)) as Icon).color, Colors.red);
  });
}

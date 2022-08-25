import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:school_todo/models/importance_model.dart';
import 'package:school_todo/styles/app_colors.dart';

import 'editing_menu_test_main.dart' as test_main;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    GetIt.instance.reset();
  });

  testWidgets('Enter in editor', (tester) async {
    test_main.main();

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text('My business'), findsOneWidget);
    expect(find.byKey(const Key('taskList')), findsOneWidget);
    expect(find.byType(Checkbox), findsNothing);

    await tester.tap(find.byIcon(Icons.add));

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.close), findsOneWidget);
    expect(find.text('Something to do...'), findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) =>
            widget is Icon &&
            widget.icon == Icons.delete &&
            widget.color == const ToDoAppLightColors(Colors.red).disable),
        findsOneWidget);
  });

  testWidgets('Create task and complete them', (tester) async {
    test_main.main();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), "123");
    expect(find.text('123'), findsOneWidget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(PopupMenuButton<Importance>));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Low'));
    await tester.pumpAndSettle();
    expect(find.text('Low'), findsOneWidget);

    await tester.tap(find.byKey(const Key('switchKey')));
    await tester.pumpAndSettle();

    await tester.tap(find.text(DateTime.now().day.toString()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    DateFormat dateFormat = DateFormat('d MMM yyyy');
    expect(find.text(dateFormat.format(DateTime.now())), findsOneWidget);

    await tester.tap(find.text('SAVE'));
    await tester.pumpAndSettle();
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.text('123'), findsOneWidget);
    expect(find.text(dateFormat.format(DateTime.now())), findsOneWidget);
    expect(find.byIcon(Icons.arrow_downward), findsOneWidget);

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    expect(find.text('123'), findsNothing);
  });
}

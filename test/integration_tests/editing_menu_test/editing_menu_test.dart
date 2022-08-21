import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:get_it/get_it.dart';
import 'package:school_todo/ui/task_list_page/widgets/title_sliver_app_bar_widget.dart';

import 'editing_menu_test_main.dart' as test_main;

void main() {
  tearDown(() {
    GetIt.instance.reset();
  });
  
  testWidgets('Enter in editor, create task and complete them', (tester) async {
    test_main.main();

    await tester.pump(const Duration(seconds: 5));
    
    expect(find.text("My business"), findsOneWidget);
    // дотык

    await tester.pump(const Duration(seconds: 3));
  });
}
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:notes_app/main.dart' as app;
import 'package:notes_app/utils/const_keys_app.dart';

void main() {
  testWidgets("Add new note testing", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

//tap add new note button
    await tester.tap(find.byKey(const Key(ConstWidgetKeysApp.buttonAddNoteKey)));

    await tester.pumpAndSettle();

//type text
    final noteName = 'New note title';
    await tester.enterText(find.byKey(const Key(ConstWidgetKeysApp.noteFormNameKey)), noteName);
    final noteContent = 'New note content';
    await tester.enterText(find.byKey(const Key(ConstWidgetKeysApp.noteFormContentKey)), noteContent);

//tap save
    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpAndSettle();

    expect(find.text(noteName), findsOneWidget);
  });
}

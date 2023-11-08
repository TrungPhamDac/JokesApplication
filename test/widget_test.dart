// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:jokeapp/jokesData.dart';
import 'package:jokeapp/main.dart';
import 'package:mockito/mockito.dart';

class MockPreferences extends Mock {
  Future<void> saveJokeId(String jokeId);
  Future<List<String>> loadJokeId();
  Future<void> clearVotedJokes();
}

class MockJokesData extends Mock {
  Future<List<Joke>> getUnvotedJokes(List<String> votedJokesIds);
}

final mockPreferences = MockPreferences();
final mockJokesData = MockJokesData();

void main() {
  testWidgets('Test if initial joke is displayed correctly',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the initial state displays a joke correctly
    expect(find.text('A joke a day keeps the doctor away'), findsOneWidget);
    expect(
        find.text(
            "If you joke the wrong way, your teeth have to pay. (Serious)"),
        findsOneWidget);
  });
}

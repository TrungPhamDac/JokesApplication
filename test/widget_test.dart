import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jokeapp/home.dart';
import 'package:jokeapp/jokesData.dart';
import 'package:jokeapp/main.dart';
import 'package:jokeapp/preferences.dart';
import 'package:mockito/mockito.dart';

class MockJokesData extends Mock implements JokesData {
  @override
  Future<List<Joke>> getUnvotedJokes(List<String> votedJokesIds) async {
    return <Joke>[
      Joke("1", "Joke Content 1"),
      Joke("2", "Joke Content 2"),
      Joke("2", "Joke Content 3"),
      Joke("4", "Joke Content 4")
    ];
  }
}

class MockPreferences extends Mock implements Preferences {
  @override
  Future<List<String>> loadJokeId() async {
    return <String>[];
  }

  @override
  Future<void> saveJokeId(String jokeId) async {}

  @override
  Future<void> clearVotedJokes() async {}
}

void main() {
  testWidgets('Test if initial joke is displayed correctly',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the initial state displays a joke correctly
    expect(find.text('A joke a day keeps the doctor away'), findsOneWidget);
    expect(
        find.text(
            "If you joke the wrong way, your teeth have to pay. (Serious)"),
        findsOneWidget);
  });
  testWidgets('Test if Jokes are displayed on screen',
      (WidgetTester tester) async {
    final MockJokesData mockJokesData = MockJokesData();
    final MockPreferences mockPreferences = MockPreferences();

    await tester.pumpWidget(
      MaterialApp(
        home: Home(jokesData: mockJokesData, preferences: mockPreferences),
      ),
    );

    await tester.pumpAndSettle();

    // Verify that a joke is displayed on screen
    expect(find.text("Joke Content 1"), findsOneWidget);
  });

  testWidgets('Test button', (WidgetTester tester) async {
    final MockJokesData mockJokesData = MockJokesData();
    final MockPreferences mockPreferences = MockPreferences();

    await tester.pumpWidget(
      MaterialApp(
        home: Home(jokesData: mockJokesData, preferences: mockPreferences),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text("This is Funny!"), findsOneWidget);
    expect(find.text("This is not funny."), findsOneWidget);

    await tester.tap(find.text('This is Funny!'));
    await tester.pump();

    await tester.tap(find.text("This is not funny."));
    await tester.pump();
  });

  testWidgets('Test if joke is changed when pressing a button',
      (WidgetTester tester) async {
    final MockJokesData mockJokesData = MockJokesData();
    final MockPreferences mockPreferences = MockPreferences();

    await tester.pumpWidget(
      MaterialApp(
        home: Home(jokesData: mockJokesData, preferences: mockPreferences),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text("Joke Content 1"), findsOneWidget);
    expect(find.text("Joke Content 2"), findsNothing);

    await tester.tap(find.text("This is Funny!"));

    await tester.pump();

    // Verify that the joke was changed.
    expect(find.text("Joke Content 1"), findsNothing);
    expect(find.text("Joke Content 2"), findsOneWidget);
  });

  testWidgets('Test if all jokes are displayed, then show end message',
      (WidgetTester tester) async {
    final MockJokesData mockJokesData = MockJokesData();
    final MockPreferences mockPreferences = MockPreferences();

    await tester.pumpWidget(
      MaterialApp(
        home: Home(jokesData: mockJokesData, preferences: mockPreferences),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text("Joke Content 1"), findsOneWidget);
    await tester.tap(find.text('This is Funny!'));
    await tester.pump();

    for (int i = 2; i <= 4; i++) {
      expect(find.text("Joke Content $i"), findsOneWidget);
      await tester.tap(find.text('This is Funny!'));
      await tester.pump();
    }

    // After all jokes are displayed, verify that the end message is shown
    expect(find.text("That's all the jokes for today! Come back another day!"),
        findsOneWidget);
  });
}

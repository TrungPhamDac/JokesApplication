import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String JOKES_KEY = "votedJokes";

  Future<void> saveJokeId(String jokeId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? votedJokesId = prefs.getStringList(JOKES_KEY) ?? [];
    votedJokesId?.add(jokeId);
    await prefs.setStringList(JOKES_KEY, votedJokesId!);
  }

  Future<List<String>> loadJokeId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(JOKES_KEY) ?? [];
  }

  Future<void> clearVotedJokes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(JOKES_KEY);
  }
}

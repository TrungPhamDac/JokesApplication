import 'package:flutter/material.dart';
import 'package:jokeapp/jokesData.dart';
import 'package:jokeapp/preferences.dart';

// ignore: must_be_immutable
class JokesSreens extends StatefulWidget {
  JokesData jokesData;
  Preferences preferences;
  JokesSreens({super.key, required this.jokesData, required this.preferences});

  @override
  State<JokesSreens> createState() => _JokesSreensState();
}

class _JokesSreensState extends State<JokesSreens> {
  bool finished = false;
  List<Joke> jokes = [];
  int currentJokeIndex = 0;

  @override
  void initState() {
    super.initState();
    loadUnvotedJokes();
  }

  Future<void> loadUnvotedJokes() async {
    List<String> votedJokesIds = await widget.preferences.loadJokeId();
    List<Joke> unvotedJokes =
        await widget.jokesData.getUnvotedJokes(votedJokesIds);
    setState(() {
      jokes = unvotedJokes;
    });
  }

  void voteJoke(String id) async {
    await widget.preferences.saveJokeId(id);
    displayNextJoke();
  }

  void clearCookie() async {
    await widget.preferences.clearVotedJokes();
    setState(() {
      finished = false;
      currentJokeIndex = 0;
    });
    loadUnvotedJokes();
  }

  void displayNextJoke() {
    if (currentJokeIndex < jokes.length - 1) {
      setState(() {
        currentJokeIndex++;
      });
    } else {
      setState(() {
        finished = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            color: const Color(0xff29b363),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "A joke a day keeps the doctor away",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "If you joke the wrong way, your teeth have to pay. (Serious)",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          finished
              ? Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      padding: const EdgeInsets.all(20.0),
                      child: const Text(
                        "That's all the jokes for today! Come back another day!",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: clearCookie,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        backgroundColor: const Color(0xff29b363),
                      ),
                      child: const Text(
                        "Read again",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              : jokes.isNotEmpty
                  ? Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            jokes[currentJokeIndex].content.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () => voteJoke(
                                    jokes[currentJokeIndex].id.toString()),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  backgroundColor: const Color(0xff2c7edb),
                                ),
                                child: const Text(
                                  "This is Funny!",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => voteJoke(
                                    jokes[currentJokeIndex].id.toString()),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  backgroundColor: const Color(0xff29b363),
                                ),
                                child: const Text(
                                  "This is not funny.",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "No jokes available.",
                          style: TextStyle(fontSize: 16),
                        ),
                        ElevatedButton(
                          onPressed: clearCookie,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            backgroundColor: const Color(0xff29b363),
                          ),
                          child: const Text(
                            "Refresh",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "This app is created as part of HLSolutions program. The materials contained on this website are provided for general information only and do not constitute any form of advice. HLS assumes no responsibility for the accuracy of any particular statement and accepts no liability for any loss or damage which may arise from reliance on the information contained on this site.",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(
              "Copyright 2021 HLS",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}

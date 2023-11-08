class Joke {
  String? id;
  String? content;
  Joke(this.id, this.content);
}

class JokesData {
  List<Joke> jokes = [
    Joke("1",
        "A child asked his father, \"How were people born?\" So his father said, \"Adam and Eve made babies, then their babies became adults and made babies, and so on.\"The child then went to his mother, asked her the same question and she told him, \"We were monkeys then we evolved to become like we are now.\"The child ran back to his father and said, \"You lied to me!\" His father replied, \"No, your mom was talking about her side of the family\"."),
    Joke("2",
        "Teacher: \"Kids,what does the chicken give you?\" Student: \"Meat!\" Teacher: \"Very good! Now what does the pig give you?\" Student: \"Bacon!\" Teacher: \"Great! And what does the fat cow give you?\" Student: \"Homework!\""),
    Joke("3",
        "The teacher asked Jimmy,\"Why is your cat at school today Jimmy?\" Jimmy replied crying, \"Because I heard my daddy tell my mommy, 'I am going to eat that pussy once Jimmy leaves for school today!'\""),
    Joke("4",
        "A housewife, an accountant and a lawyer were asked \"How much is 2+2?\" The housewife replies: \"Four!\". The accountant says: \"I think it's either 3 or 4. Let me run those figures through my spreadsheet one more time.\" The lawyer pulls the drapes, dims the lights and asks in a hushed voice, \"How much do you want it to be?\"")

    // Joke("1", "A"),
    // Joke("2", "B"),
    // Joke("3", "C"),
    // Joke("4", "D")
  ];

  Future<List<Joke>> getUnvotedJokes(List<String> votedJokesIds) async {
    List<Joke> unvotedJokes =
        jokes.where((joke) => !votedJokesIds.contains(joke.id)).toList();
    return unvotedJokes;
  }
}

enum CardStatus { ready, right, wrong }

class FlashCard {
  final int a;
  final int b;
  const FlashCard(this.a, this.b);

  int answer() {
    return a * b;
  }
}

class FlashCardDeck {
  List<FlashCard> cards = [];
  List<FlashCard> wrong = [];
  List<FlashCard> current = [];
  List<List<FlashCard>> levels = [];

  FlashCardDeck(List<int> values) {
    for (int v in values) {
      for (var i = 1; i <= 4; i++) {
        cards.add(FlashCard(v, i));
      }
    }
    cards.shuffle();
    levels.add(List<FlashCard>.from(cards));
  }

  void advance() {
    if (levels.isNotEmpty) {
      if (wrong.isNotEmpty) {
        wrong.shuffle();
        levels.add(wrong);
      } else {
        levels[levels.length - 2].addAll(levels[levels.length - 1]);
        levels.removeLast();
        levels[levels.length - 1].shuffle();
      }
    }
  }

  bool startRound() {
    if (levels.isNotEmpty) {
      current.addAll(levels[levels.length - 1]);
      levels[levels.length - 1].clear();
      return true;
    }
    return false;
  }

  bool hasNext() {
    return current.isNotEmpty;
  }

  FlashCard next() {
    if (current.isNotEmpty) {
      return current.removeLast();
    }
    throw Exception();
  }

  void correct(FlashCard card) {
    levels[levels.length - 1].add(card);
  }

  void incorrect(FlashCard card) {
    wrong.add(card);
  }

  int total() {
    return cards.length;
  }

  int topTotal() {
    return levels[levels.length - 1].length;
  }

  void shuffle() {
    cards.shuffle();
  }
}
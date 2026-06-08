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

  FlashCardDeck(List<int> values) {
    for (int v in values) {
      for (var i = 1; i <= 12; i++) {
        cards.add(FlashCard(v, i));
      }
    }
  }

  void shuffle() {
    cards.shuffle();
  }
}
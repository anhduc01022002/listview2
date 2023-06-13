class Card {
  final String imagePath;
  final String matchName;

  Card(this.imagePath,this.matchName);
}
class Game{
  final String hiddenCard = 'images/hidden_card.jpeg';
  List<String>? gameImg;

  final List<Card> card_list = [
    Card("images/cat1.jpeg", "cat"),
    Card("images/cat2.jpeg", "cat"),
    Card("images/chicken1.jpeg", "chicken"),
    Card("images/chicken2.jpeg", "chicken"),
    Card("images/dog1.jpeg", "dog"),
    Card("images/dog2.jpeg", "dog"),
  ];

  List<Map<int,String>> matchCheck = [];

  final int cardCount = 6;

  void initGame(){
    gameImg = List.generate(cardCount, (index) => hiddenCard);
    card_list.shuffle();
  }
  void flipCard(int index) {
    gameImg![index] = card_list[index].imagePath;
  }

  void checkMatch(int index1, int index2) {
    if (card_list[index1].matchName != card_list[index2].matchName) {
      gameImg![index1] = hiddenCard;
      gameImg![index2] = hiddenCard;
    }
  }

  bool isGameOver() {
    return !gameImg!.contains(hiddenCard);
  }
}
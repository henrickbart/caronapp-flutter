class Background {
  ///Retorna o nome do asset a ser usado no background de acordo com o indice da lista
  static String getAssetName(int index) {
    if (index % 3 == 0) {
      return "assets/card_background3.jpg";
    } else if (index % 2 == 0) {
      return "assets/card_background2.jpg";
    } else {
      return "assets/card_background1.jpg";
    }
  }
}

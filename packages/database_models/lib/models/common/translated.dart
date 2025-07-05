class Translated {
  String translatedVi;
  String translatedZh;
  bool translated;

  Translated({required this.translatedVi, required this.translatedZh, required this.translated});

  @override
  String toString() {
    return 'Translated{translatedVi: $translatedVi, translatedZh: $translatedZh, translated: $translated}';
  }
}

class CardHomeInfo {
  CardHomeInfo({
    required this.title,
    required this.content,
    required this.author,
    required this.dateTime,
    required this.cardType,
    required this.isRead,
    required this.isPinned,
    required this.images,
    required this.files,
  });

  final String title;
  final String content;
  final String author;
  final DateTime dateTime;
  final String cardType;
  bool isRead;
  bool isPinned;
  final List<String> images;
  final List<String> files;
}

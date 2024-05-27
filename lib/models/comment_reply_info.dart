class CommentReplyInfo {
  CommentReplyInfo( {
    required this.content,
    required this.author,
    required this.dateTime,
    required this.authorImageUrl,
  });

  final String content;
  final String author;
  final DateTime dateTime;
  final String? authorImageUrl;
}

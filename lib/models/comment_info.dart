import 'package:school_app/models/comment_reply_info.dart';

class CommentInfo {
  CommentInfo({
    required this.content,
    required this.author,
    required this.dateTime,
    required this.authorImageUrl, 
    required this.replies,
  });

  final String content;
  final String author;
  final DateTime dateTime;
  final String? authorImageUrl;
  final List<CommentReplyInfo>? replies;
}

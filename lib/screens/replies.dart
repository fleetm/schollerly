import 'package:flutter/material.dart';
import 'package:school_app/models/comment_reply_info.dart';
import 'package:school_app/widgets/reply.dart';

class RepliesSheet extends StatefulWidget {
  const RepliesSheet({
    super.key,
    required this.replies,
  });

  final List<CommentReplyInfo>? replies;

  @override
  State<RepliesSheet> createState() => _RepliesSheetState();
}

class _RepliesSheetState extends State<RepliesSheet> {
  int index = 0;
  String formatTimeDifference(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'قبل ثوانٍ';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      if (minutes == 1) {
        return 'قبل دقيقة';
      } else if (minutes == 2) {
        return 'قبل دقيقتان';
      } else if (minutes >= 3 && minutes <= 10) {
        return 'قبل $minutes دقائق';
      } else {
        return 'قبل $minutes دقيقة';
      }
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      if (hours == 1) {
        return 'قبل ساعة';
      } else if (hours == 2) {
        return 'قبل ساعتان';
      } else {
        return 'قبل $hours ساعات';
      }
    } else if (difference.inDays == 1) {
      return 'قبل يوم واحد';
    } else if (difference.inDays == 2) {
      return 'قبل يومان';
    } else if (difference.inDays > 2 && difference.inDays <= 10) {
      return 'قبل ${difference.inDays} أيام';
    } else if (difference.inDays > 10 && difference.inDays <= 30) {
      return 'قبل ${difference.inDays ~/ 7} أسابيع';
    } else if (difference.inDays > 30 && difference.inDays <= 365) {
      return 'قبل ${difference.inDays ~/ 30} شهور';
    } else if (difference.inDays > 365) {
      return 'قبل ${difference.inDays ~/ 365} سنوات';
    } else {
      // Handle longer durations as needed
      // You can add further logic for centuries, etc.
      return 'قبل فترة طويلة';
    }
  }

  final TextEditingController _commentController = TextEditingController();
  bool showScrollToTopButton = false;
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F6F6),
        scrolledUnderElevation: 0,
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "الردود",
            style: TextStyle(
              fontFamily: 'Dubai',
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: NotificationListener<ScrollUpdateNotification>(
                  onNotification: (notification) {
                    final scrollPosition = notification.metrics.pixels;
                    if (scrollPosition > 0 && !showScrollToTopButton) {
                      setState(() {
                        showScrollToTopButton = true;
                      });
                    } else if (scrollPosition == 0 && showScrollToTopButton) {
                      setState(() {
                        showScrollToTopButton = false;
                      });
                    }
                    return true;
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Use dummyComments list instead of comments
                        ...widget.replies!.map(
                          (comment) => Reply(
                            index: index++,
                            profile: comment.author,
                            content: comment.content,
                            date: formatTimeDifference(comment.dateTime),
                            authorImageUrl: comment.authorImageUrl,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(height: 0),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    'تعليق جديد',
                                    textAlign: TextAlign.right,
                                  ),
                                  content: const Text(
                                    'هل انت متأكد انك تريد نشر التعليق؟',
                                    textAlign: TextAlign.right,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('إلغاء'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Implement functionality to add comment
                                        Navigator.pop(context);
                                      },
                                      child: const Text('نشر'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.send, color: Colors.blue),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width - 70,
                        child: TextField(
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          textAlign: TextAlign.right,
                          controller: _commentController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            hintText: '...أضف ردك هنا',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            top: showScrollToTopButton ? 16 : kToolbarHeight - 200,
            right: MediaQuery.of(context).size.width / 2 - 28,
            child: FloatingActionButton(
              heroTag: 'scrollToTopButton',
              onPressed: () {
                scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              mini: true,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(Icons.arrow_upward),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:school_app/data/dummy_data.dart';
//import 'package:school_app/screens/comments.dart';
import 'package:school_app/widgets/comment.dart';
import 'package:school_app/widgets/home_card.dart';
import 'package:intl/intl.dart' as intl;

// ignore: must_be_immutable
class FullPostScreen extends StatefulWidget {
  FullPostScreen({
    Key? key,
    required this.title,
    required this.content,
    required this.author,
    required this.dateTime,
    required this.cardType,
    this.authorImageUrl,
    required this.index,
    required this.images,
    required this.files,
    required this.isRead,
    required this.isPinned,
  }) : super(key: key);

  final String title;
  String content;
  final String author;
  final DateTime dateTime;
  final String cardType;
  final String? authorImageUrl;
  bool isRead = false;
  bool isPinned = false;
  final int index;
  final List<String> images;
  final List<String> files;

  @override
  State<StatefulWidget> createState() {
    return _FullPostScreenState();
  }
}

class _FullPostScreenState extends State<FullPostScreen> {
  @override
  void initState() {
    super.initState();
  }

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

  var _scrollParent = false;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F6F6),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(
                        0, 3), // changes the position of the shadow
                  ),
                ],
              ),
              child: Material(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      PageView.builder(
                        reverse: true,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        itemCount: widget.images.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FullScreenImage(
                                    selectedImages: widget.images,
                                    index: index,
                                  ),
                                ),
                              );
                            },
                            child: Image.network(
                              widget.images[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: MediaQuery.of(context).padding.top,
                        left: 10,
                        child: FloatingActionButton(
                          shape: const CircleBorder(),
                          mini: true,
                          backgroundColor: const Color(0xFFF0F6F6),
                          onPressed: () {
                            Navigator.of(context).pop({
                              'isPinned': widget.isPinned,
                              'isRead': widget.isRead,
                            });
                          },
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).padding.top,
                        right: 10,
                        child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                            color: Color(0xFFF0F6F6),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '${_currentIndex + 1} / ${widget.images.length}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            color: widget.isPinned ? Colors.red : Colors.black,
                            icon: Icon(widget.isPinned
                                ? Icons.push_pin
                                : Icons.push_pin_outlined),
                            onPressed: () {
                              setState(() {
                                dummyCardHomeData[widget.index].isPinned =
                                    !dummyCardHomeData[widget.index].isPinned;

                                widget.isPinned =
                                    dummyCardHomeData[widget.index].isPinned;
                              });
                            },
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.author,
                                style: const TextStyle(
                                    fontFamily: 'Dubai',
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (!widget.isRead)
                                    const Row(
                                      children: [
                                        Text(
                                          'غير مقروءة',
                                          style: TextStyle(
                                            fontFamily: 'Dubai',
                                            fontSize: 12,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                        Icon(
                                          Icons.notifications,
                                          size: 14,
                                          color: Colors.redAccent,
                                        ),
                                      ],
                                    ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    intl.DateFormat('MMMM d, y hh:mm a')
                                        .format(widget.dateTime),
                                    style: const TextStyle(
                                      fontFamily: 'Dubai',
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          if (widget.authorImageUrl != null)
                            CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  NetworkImage(widget.authorImageUrl!),
                            )
                          else
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                  'assets/icons/icons8-christmas-boy-64.png'),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.title,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontFamily: 'Dubai',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          widget.content,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontFamily: 'Dubai',
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ReactionButton<String>(
                              placeholder: // Add placeholder
                                  const Reaction<String>(
                                value: 'Add Reaction',
                                icon: Icon(Icons.add_reaction_outlined),
                              ),
                              itemSize: const Size(40, 30),
                              onReactionChanged:
                                  (Reaction<String>? reaction) {},
                              reactions: const <Reaction<String>>[
                                Reaction<String>(
                                  value: 'like',
                                  icon: Icon(FontAwesomeIcons.thumbsUp,
                                      color: Colors.blue),
                                ),
                                Reaction<String>(
                                  value: 'love',
                                  icon: Icon(FontAwesomeIcons.heart,
                                      color: Colors.red),
                                ),
                                Reaction<String>(
                                  value: 'wow',
                                  icon: Icon(FontAwesomeIcons.faceSurprise,
                                      color: Colors.yellow),
                                ),
                                Reaction<String>(
                                  value: 'sad',
                                  icon: Icon(FontAwesomeIcons.faceSadTear,
                                      color: Colors.lightBlue),
                                ),
                                Reaction<String>(
                                  value: 'angry',
                                  icon: Icon(FontAwesomeIcons.faceAngry,
                                      color: Colors.redAccent),
                                ),
                              ],
                              // selectedReaction: const Reaction<String>(
                              //   value: 'like_fill',
                              //   icon: Icon(Icons.thumb_up),
                              // ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: Icon(
                                widget.isRead
                                    ? Icons.mark_email_read_outlined
                                    : Icons.mark_email_unread_outlined,
                                color:
                                    widget.isRead ? Colors.blue : Colors.black,
                              ),
                              onPressed: () {
                                if (widget.index < dummyCardHomeData.length) {
                                  setState(() {
                                    dummyCardHomeData[widget.index].isRead =
                                        !dummyCardHomeData[widget.index].isRead;

                                    widget.isRead =
                                        dummyCardHomeData[widget.index].isRead;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      DefaultTabController(
                        initialIndex: 1,
                        length: 2,
                        child: Column(
                          children: [
                            const TabBar(
                              tabs: [
                                Tab(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('الملفات المرفقة'),
                                      SizedBox(width: 8),
                                      Icon(Icons.attach_file),
                                    ],
                                  ),
                                ),
                                Tab(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('التعليقات'),
                                      SizedBox(width: 8),
                                      Icon(Icons.comment),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: TabBarView(
                                children: [
                                  widget.files.isEmpty
                                      ? const Column(
                                          children: [
                                            SizedBox(height: 32),
                                            Text(
                                              textAlign: TextAlign.center,
                                              'لا توجد ملفات مرفقة',
                                              style: TextStyle(
                                                  fontFamily: 'Dubai',
                                                  fontSize: 18),
                                            ),
                                          ],
                                        )
                                      : IgnorePointer(
                                          ignoring: _scrollParent,
                                          child: NotificationListener<
                                              OverscrollNotification>(
                                            onNotification: (_) {
                                              setState(() {
                                                _scrollParent = true;
                                              });

                                              Timer(const Duration(seconds: 1),
                                                  () {
                                                setState(() {
                                                  _scrollParent = false;
                                                });
                                              });

                                              return false;
                                            },
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 8),
                                              itemCount: widget.files.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final fileName = widget
                                                    .files[index]
                                                    .split('/')
                                                    .last;
                                                return Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Card(
                                                    color: Colors.white,
                                                    surfaceTintColor:
                                                        Colors.white,
                                                    elevation: 3,
                                                    child: ListTile(
                                                      title: Text(fileName),
                                                      trailing: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons.download),
                                                            onPressed: () {
                                                              // Implement download functionality
                                                            },
                                                          ),
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons.share),
                                                            onPressed: () {
                                                              // Implement share functionality
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                  // widget.comments.isEmpty
                                  //     ? const Column(
                                  //         children: [
                                  //           SizedBox(height: 32),
                                  //           Text(
                                  //             textAlign: TextAlign.center,
                                  //             'لا توجد تعليقات حاليا',
                                  //             style: TextStyle(
                                  //                 fontFamily: 'Dubai',
                                  //                 fontSize: 18),
                                  //           ),
                                  //         ],
                                  //       )
                                  //     :
                                  IgnorePointer(
                                    ignoring: _scrollParent,
                                    child: NotificationListener<
                                        OverscrollNotification>(
                                      onNotification: (_) {
                                        setState(() {
                                          _scrollParent = true;
                                        });

                                        Timer(const Duration(seconds: 1), () {
                                          setState(() {
                                            _scrollParent = false;
                                          });
                                        });

                                        return false;
                                      },
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            // Use dummyComments list instead of comments
                                            ...dummyComments.map(
                                              (comment) => Comment(
                                                index: dummyComments
                                                    .indexOf(comment),
                                                profile: comment.author,
                                                content: comment.content,
                                                date: formatTimeDifference(
                                                    comment.dateTime),
                                                replies: comment.replies,
                                                authorImageUrl:
                                                    comment.authorImageUrl,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

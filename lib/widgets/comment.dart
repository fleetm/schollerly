import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:school_app/models/comment_reply_info.dart';
import 'package:school_app/screens/replies.dart';

class Comment extends StatelessWidget {
  const Comment({
    super.key,
    required this.profile,
    required this.content,
    required this.date,
    required this.authorImageUrl,
    required this.replies,
    required this.index,
  });
  final int index;
  final String profile;
  final String content;
  final String date;
  final String? authorImageUrl;
  final List<CommentReplyInfo>? replies;

  @override
  Widget build(BuildContext context) {
    final replyConunt = replies?.length ?? 0;
    String replyText;
    switch (replyConunt) {
      case 0:
        replyText = 'الرد';
        break;
      case 1:
        replyText = 'رد واحد';
        break;
      case 2:
        replyText = 'ردان';
        break;
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
      case 8:
      case 9:
      case 10:
        replyText = '$replyConunt ردود ';
        break;

      default:
        replyText = '$replyConunt رد';
    }

    return Column(
      children: [
        if (index != 0) const Divider(),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          date,
                          style: const TextStyle(
                            fontFamily: 'Dubai',
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,

                          ),
                        ),
                        const Spacer(),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            profile,
                            style: const TextStyle(
                              fontFamily: 'Dubai',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        content,
                        style: const TextStyle(fontSize: 16, fontFamily: 'Dubai'),
                      ),
                    ),
                    //const SizedBox(height: 5),
                    Row(
                      children: [
                        ReactionButton<String>(
                          placeholder: // Add placeholder
                              const Reaction<String>(
                            value: 'Add Reaction',
                            icon: Icon(Icons.add_reaction_outlined),
                          ),
                          itemSize: const Size(40, 30),
                          onReactionChanged: (Reaction<String>? reaction) {
                            
                          },
                          reactions: const <Reaction<String>>[
                            Reaction<String>(
                              value: 'like',
                              icon: Icon(FontAwesomeIcons.thumbsUp, color: Colors.blue),
                            ),
                            Reaction<String>(
                              value: 'love',
                              icon: Icon(FontAwesomeIcons.heart, color: Colors.red),
                            ),
                            Reaction<String>(
                              value: 'wow',
                              icon: Icon(FontAwesomeIcons.faceSurprise, color: Colors.yellow),
                            ),
                            Reaction<String>(
                              value: 'sad',
                              icon: Icon(FontAwesomeIcons.faceSadTear, color: Colors.lightBlue),
                            ),
                            Reaction<String>(
                              value: 'angry',
                                icon: Icon(FontAwesomeIcons.faceAngry, color: Colors.redAccent),
                            ),
                          ],
                          // selectedReaction: const Reaction<String>(
                          //   value: 'like_fill',
                          //   icon: Icon(Icons.thumb_up),
                          // ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                if (authorImageUrl != null)
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(authorImageUrl!),
                  )
                else
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage:
                        AssetImage('assets/icons/icons8-christmas-boy-64.png'),
                  ),
                TextButton(
                  onPressed: () {
                    showMaterialModalBottomSheet(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      isDismissible: true,
                      context: context,
                      builder: (ctx) => FractionallySizedBox(
                        heightFactor:
                            1, // Adjust this value to control the height
                        child: RepliesSheet(
                          replies: replies ?? [],
                        ),
                      ),
                    );
                  },
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      replyText,
                      style: const TextStyle(
                        fontFamily: 'Dubai' ,
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

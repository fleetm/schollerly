import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Reply extends StatelessWidget {
  const Reply({
    super.key,
    required this.profile,
    required this.content,
    required this.date,
    required this.authorImageUrl,
    required this.index,
  });
  final int index;
  final String profile;
  final String content;
  final String date;
  final String? authorImageUrl;

  @override
  Widget build(BuildContext context) {
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
                        style:
                            const TextStyle(fontSize: 16, fontFamily: 'Dubai'),
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
                          onReactionChanged: (Reaction<String>? reaction) {},
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
              ],
            ),
          ],
        ),
      ],
    );
  }
}

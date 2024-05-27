import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var isReadG = false;

class MessageCard extends StatefulWidget {
  const MessageCard({
    super.key,
    required this.content,
    required this.author,
    required this.dateTime,
    this.authorImageUrl,
    required this.cardType, // Initialize the new property as nullable
  });

  final String content;
  final String author;
  final String dateTime;
  final String cardType;
  final String? authorImageUrl;

  @override
  State<MessageCard> createState() {
    return _MessageCard();
  }
}

class _MessageCard extends State<MessageCard> {
  bool isRead = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 3,
        child: InkWell(
          onTap: () {
            setState(() {
              //navegate to chat
              isRead = true;
            });
          },
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.dateTime,
                  style: GoogleFonts.notoSansArabic(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 65),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.author,
                      style: GoogleFonts.notoSansArabic(),
                    ),
                    SizedBox(
                      width: 180,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          widget.cardType == 'group'
                              ? 'المرسل: ${widget.content}'
                              : widget.content,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.notoSansArabic(
                            fontSize: 12,
                            fontWeight:
                                isRead ? FontWeight.normal : FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                if (widget.authorImageUrl != null)
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(widget.authorImageUrl!),
                  )
                else
                  CircleAvatar(
                      backgroundImage:
                          const AssetImage('assets/icons/temps.png'),
                      radius: 20,
                      child: Icon(
                        widget.cardType == 'group'
                            ? Icons.groups
                            : Icons.person,
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:photo_view/photo_view.dart';
import 'package:school_app/data/dummy_data.dart';
import 'package:intl/intl.dart' as intl;
import 'package:school_app/screens/comments.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:school_app/screens/full_post.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class HomeCard extends StatefulWidget {
  HomeCard({
    super.key,
    required this.title,
    required this.content,
    required this.author,
    required this.dateTime,
    this.authorImageUrl,
    required this.cardType, // Initialize the new property as nullable
    required this.isRead,
    required this.isPinned,
    required this.index,
    required this.images,
    required this.files,
  });

  final String title;
  final String content;
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
  State<HomeCard> createState() {
    return _HomeCard();
  }
}

class _HomeCard extends State<HomeCard> {
  int lines = 4;
  String buttonText = 'إقرأ أكثر';
  void readMore() {
    if (lines == 4) {
      setState(() {
        lines = widget.content.length;
        buttonText = 'إقرأ إقل';
      });
    } else {
      setState(() {
        lines = 4;
        buttonText = 'إقرأ أكثر';
      });
    }
  }

  bool contentExceedsTwoLines(BuildContext context, String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontFamily: 'Dubai',
        ),
      ),
      maxLines: 4,
      textDirection: TextDirection.rtl,
    )..layout(
        maxWidth: MediaQuery.of(context).size.width - 75,
      );

    return textPainter.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    int commentCount = 5; // Replace with the actual comment count
    return GestureDetector(
      onTap: () async {
        final Map<String, bool?>? result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return FullPostScreen(
                title: widget.title,
                content: widget.content,
                author: widget.author,
                dateTime: widget.dateTime,
                cardType: widget.cardType,
                authorImageUrl: widget.authorImageUrl,
                index: widget.index,
                images: widget.images,
                files: widget.files,
                isPinned: widget.isPinned,
                isRead: widget.isRead,
              );
            },
          ),
        );

        if (result != null) {
          setState(() {
            widget.isPinned = result['isPinned'] ?? widget.isPinned;
            widget.isRead = result['isRead'] ?? widget.isRead;
          });
        }
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              color:
                                  widget.isPinned ? Colors.red : Colors.black,
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
                            maxLines: lines,
                            overflow: TextOverflow.ellipsis,
                            widget.content,
                            style: const TextStyle(
                              fontFamily: 'Dubai',
                            ),
                          ),
                        ),
                        if (contentExceedsTwoLines(context, widget.content))
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: readMore,
                              child: Text(
                                buttonText,
                                style: const TextStyle(
                                  fontFamily: 'Dubai',
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (widget.images.isNotEmpty) const SizedBox(height: 10),
                  if (widget.images.isEmpty) const Divider(),
                  if (widget.images.length == 1)
                    GestureDetector(
                      child: Image.network(
                        widget.images[0],
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return FadeTransition(
                                opacity: animation,
                                child: FullScreenImage(
                                  selectedImages: widget.images,
                                  index: 0,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  if (widget.images.isNotEmpty && widget.images.length > 1)
                    SizedBox(
                      height: 200,
                      child: PhotoGrid(
                        imageUrls: widget.images,
                        onImageClicked: (index) {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false,
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: FullScreenImage(
                                    selectedImages: widget.images,
                                    index: index,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
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
                        const SizedBox(width: 10),
                        IconButton(
                          icon: Icon(
                            widget.isRead
                                ? Icons.mark_email_read_outlined
                                : Icons.mark_email_unread_outlined,
                            color: widget.isRead ? Colors.blue : Colors.black,
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
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.attach_file),
                          onPressed: () {
                            showMaterialModalBottomSheet(
                              backgroundColor: const Color(0xfff0f6f6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              isDismissible: true,
                              context: context,
                              builder: (ctx) => FractionallySizedBox(
                                heightFactor:
                                    0.4, // Adjust this value to control the height
                                child: ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  itemCount: widget.files
                                      .length, // Assuming attachedFiles is a list of file names
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final fileName =
                                        widget.files[index].split('/').last;
                                    return Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Card(
                                        color: Colors.white,
                                        surfaceTintColor: Colors.white,
                                        elevation: 3,
                                        child: ListTile(
                                          title: Text(fileName),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon:
                                                    const Icon(Icons.download),
                                                onPressed: () {
                                                  // Implement download functionality
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.share),
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
                            );
                          },
                        ),

                        Text(
                            '${widget.files.length}'), // Display attachment count
                        const SizedBox(
                          width: 10,
                        ), // Add some space between icon and count
                        IconButton(
                          icon: const Icon(Icons.comment),
                          onPressed: () {
                            showMaterialModalBottomSheet(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              isDismissible: true,
                              context: context,
                              builder: (ctx) => const FractionallySizedBox(
                                heightFactor: 1,
                                child: CommentsSheet(),
                              ),
                            );
                          },
                        ),
                        Text('$commentCount'), // Display comment count
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 12, // Adjust the position as needed
            left: 20, // Adjust the position as needed
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: const BoxDecoration(
                color: Color(0xfff0f6f6), // Adjust the color as needed
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
              ),
              child: Text(
                widget.cardType,
                style: const TextStyle(
                  fontFamily: 'Dubai',
                  color: Color(0xff0092ff), // Adjust the text color as needed
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhotoGrid extends StatelessWidget {
  final int maxImages;
  final List<String> imageUrls;
  final Function(int) onImageClicked;

  const PhotoGrid({
    required this.imageUrls,
    required this.onImageClicked,
    this.maxImages = 4,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrls.length == 2) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              child: Image.network(
                imageUrls[1],
                fit: BoxFit.cover,
              ),
              onTap: () => onImageClicked(1),
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: GestureDetector(
              child: Image.network(
                imageUrls[0],
                fit: BoxFit.cover,
              ),
              onTap: () => onImageClicked(0),
            ),
          ),
        ],
      );
    } else if (imageUrls.length == 3) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Image.network(
                      imageUrls[1],
                      fit: BoxFit.cover,
                    ),
                    onTap: () => onImageClicked(1),
                  ),
                ),
                const SizedBox(height: 2),
                Expanded(
                  child: GestureDetector(
                    child: Image.network(
                      imageUrls[2],
                      fit: BoxFit.cover,
                    ),
                    onTap: () => onImageClicked(2),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: GestureDetector(
              child: Image.network(
                imageUrls[0],
                fit: BoxFit.cover,
              ),
              onTap: () => onImageClicked(0),
            ),
          ),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Image.network(
                      imageUrls[2],
                      fit: BoxFit.cover,
                    ),
                    onTap: () => onImageClicked(2),
                  ),
                ),
                const SizedBox(height: 2),
                Expanded(
                  child: imageUrls.length > 4
                      ? GestureDetector(
                          onTap: () => onImageClicked(3),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(imageUrls[3], fit: BoxFit.cover),
                              Positioned.fill(
                                child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.black54,
                                  child:
                                      Text('+${imageUrls.length - maxImages}',
                                          style: const TextStyle(
                                            fontSize: 32,
                                            color: Color(0xfff0f6f6),
                                          )),
                                ),
                              ),
                            ],
                          ),
                        )
                      : GestureDetector(
                          child: Image.network(
                            imageUrls[3],
                            fit: BoxFit.cover,
                          ),
                          onTap: () => onImageClicked(3),
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Image.network(
                      imageUrls[0],
                      fit: BoxFit.cover,
                    ),
                    onTap: () => onImageClicked(0),
                  ),
                ),
                const SizedBox(height: 2),
                Expanded(
                  child: GestureDetector(
                    child: Image.network(
                      imageUrls[1],
                      fit: BoxFit.cover,
                    ),
                    onTap: () => onImageClicked(1),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}

class FullScreenImage extends StatefulWidget {
  final List<String> selectedImages;
  final int index;
  const FullScreenImage({
    Key? key,
    required this.selectedImages,
    required this.index,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FullScreenImageState();
  }
}

class _FullScreenImageState extends State<FullScreenImage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          Navigator.pop(context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.format_list_bulleted_rounded,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${_currentIndex + 1} / ${widget.selectedImages.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      decoration: TextDecoration.none, // Remove underline
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.clear_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PhotoViewGallery.builder(
                //enableRotation: true,
                // allowImplicitScrolling: true,
                reverse: true,
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(widget.selectedImages[index]),
                    initialScale: PhotoViewComputedScale.contained * 1,
                    heroAttributes: PhotoViewHeroAttributes(tag: index),
                  );
                },
                itemCount: widget.selectedImages.length,
                loadingBuilder: (context, event) => Center(
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes!,
                    ),
                  ),
                ),
                backgroundDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                pageController: PageController(initialPage: widget.index),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

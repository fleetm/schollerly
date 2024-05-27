import 'dart:io';
//import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class PhotoAlbumPage extends StatelessWidget {
  final List<String> descriptions = [
    'Outdoor Adventure 🌳🔍',
    'Creative Arts and Crafts 🎨',
    'Superhero Training Camp 🦸‍♂️',
    'Dinosaur Discovery Day 🦕',
    'Space Explorer Workshop 🌌',
    'Cooking with Kids 👩‍🍳👨‍🍳',
    'Music and Rhythm Jam 🎶',
    'Sports Extravaganza ⚽🏆',
    'Animal Safari Adventure 🐾',
    'Science Whiz Exploration 🔬',

    // ... add more descriptions as needed
  ];

  PhotoAlbumPage({super.key});
  // add later a box for the text a specific number of characters
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo gallery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  String imageName = 'kid${index + 1}.jpg';
                  String description = descriptions[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PhotoDetailPage(imageName, description),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Image.asset(
                                  'assets/gallery/$imageName',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0), // Adjust the spacing as needed
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}

class PhotoDetailPage extends StatelessWidget {
  final String imageName;
  final String description;

  const PhotoDetailPage(this.imageName, this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Detail'),
        backgroundColor: const Color(0xFF0FBBF9),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: kToolbarHeight + 16.0), // Space between app bar and images
            child: Container(
              color: const Color(0xFFEAE9EF), // Background color
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  String smallImageName = 'kid${index + 1}.jpg';
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenImagePage(
                            imageNames: List.generate(
                                10, (index) => 'kid${index + 1}.jpg'),
                            initialIndex: index,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/gallery/$smallImageName',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: kToolbarHeight - 48.0, // Move the text box above the app bar
            left: 16.0,
            right: 16.0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 123, 149, 232),
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenImagePage extends StatefulWidget {
  final List<String> imageNames;
  final int initialIndex;

  const FullScreenImagePage(
      {super.key, required this.imageNames, this.initialIndex = 0});

  @override
  State<StatefulWidget> createState() {
    return _FullScreenImagePageState();
  }
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  Future<void> _saveImageToDevice(BuildContext context) async {
    try {
      String currentImageName = widget.imageNames[currentIndex];

      // Get the app's document directory using path_provider
      final directory = await getApplicationDocumentsDirectory();
      String path = '${directory.path}/$currentImageName';

      // Copy the image from assets to the document directory
      ByteData data = await rootBundle.load('assets/gallery/$currentImageName');
      List<int> bytes = data.buffer.asUint8List();
      await File(path).writeAsBytes(bytes);

      // Save the image to the device's gallery using image_gallery_saver
      await ImageGallerySaver.saveFile(path);

      // Show a message indicating that the image is saved
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image saved to gallery')),
      );
    } catch (e) {
      // Handle errors, if any
      if (kDebugMode) {
        print('Error saving image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Screen Image'),
        backgroundColor: Colors.black,
      ),
      body: PageView.builder(
        itemCount: widget.imageNames.length,
        controller: PageController(initialPage: widget.initialIndex),
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          String imageName = widget.imageNames[index];
          return Container(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'assets/gallery/$imageName',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          backgroundColor: Colors.red,
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: () => _saveImageToDevice(context),
                          backgroundColor: Colors.blue,
                          child: const Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

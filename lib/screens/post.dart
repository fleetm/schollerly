import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_app/data/dummy_data.dart';
import 'package:school_app/models/card_home_info.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedPostType = 'إعلان'; // Default selected type
  List<String> attachedImages = [];
  List<String> attachedFiles = [];
  String title = '';
  String content = '';
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void _resetFields() {
    setState(() {
      titleController.text = '';
      contentController.text = '';
      // Reset other controllers for other input fields
    });
  }

  void _handlePublish(
      String title, String content, String author, String selectedPostType) {
    if (attachedImages.isNotEmpty) {
      // You have selected images, process them here
      for (String imagePath in attachedImages) {
        // Perform logic with imagePath
        if (kDebugMode) {
          print('Selected Image Path: $imagePath');
        }
      }
    }
    if (title.trim().isEmpty) {
      // Show an alert indicating that the title is required
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'خطأ',
              textAlign: TextAlign.right,
            ),
            content: const Text(
              'يجب إدخال عنوان للمنشور',
              textAlign: TextAlign.right,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Close the alert dialog
                  Navigator.pop(context);
                },
                child: const Text('حسناً'),
              ),
            ],
          );
        },
      );
      return; // Do not proceed with publishing if the title is not valid
    }

    // Create a new CardHomeInfo object
    CardHomeInfo newCardInfo = CardHomeInfo(
      title: title,
      content: content,
      author: author,
      dateTime: DateTime.now(),
      cardType: selectedPostType,
      isPinned: false, // You can change this based on your logic
      isRead: false, // You can change this based on your logic
      images: attachedImages,
      files: attachedFiles,
    );

    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceAround,
          title: const Text(
            'تأكيد النشر',
            textAlign: TextAlign.right,
          ),
          content: const Text(
            'هل أنت متأكد أنك تريد نشر هذا المنشور؟',
            textAlign: TextAlign.right,
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.pop(context);
              },
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                // Add the new CardHomeInfo to the dummyCardHomeData list
                setState(() {
                  dummyCardHomeData.add(newCardInfo);
                });

                // Close the dialog
                Navigator.pop(context);

                _resetFields();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'تم نشر المنشور بنجاح',
                      textAlign: TextAlign.right,
                    ),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                  ),
                );
              },
              child: const Text('نعم، نشر'),
            ),
          ],
        );
      },
    );
  }

  Future<String> _copyImageToAssets(String imagePath) async {
    final appDir = await getApplicationDocumentsDirectory();
    final galleryDir = Directory('${appDir.path}/assets/gallery');
    final newImagePath =
        '${galleryDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Create the assets/gallery directory if it doesn't exist
    if (!galleryDir.existsSync()) {
      galleryDir.createSync(recursive: true);
    }

    // Copy the image file to assets/gallery
    await File(imagePath).copy(newImagePath);

    return newImagePath;
  }

  Future<String?> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Get the file path from the result
      String filePath = result.files.single.path!;
      return filePath;
    }

    return null; // User canceled file picking
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: const Color(0xFFF0F6F6),
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color(0xFF0092FF),
                    Color.fromARGB(255, 120, 196, 255),
                  ],
                ),
              ),
            ),
            title: const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "إضافة",
                style: TextStyle(
                  fontFamily: 'Dubai',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            automaticallyImplyLeading: false,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(32.0),
              child: SizedBox(),
            ),
          ),
          body: null,
        ),
        Positioned(
          top: kToolbarHeight * 2,
          left: 16,
          right: 16,
          child: Column(
            children: [
              Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 8.0),
                      TextField(
                        controller: titleController,
                        onChanged: (value) {
                          setState(() {
                            title = value;
                          });
                        },
                        style: const TextStyle(
                          fontFamily: 'Dubai',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        decoration: const InputDecoration(
                          hintText: 'أدخل عنوان المنشور',
                          hintStyle: TextStyle(
                            fontFamily: 'Dubai',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      TextField(
                        controller: contentController,
                        onChanged: (value) {
                          setState(() {
                            content = value;
                          });
                        },
                        style: const TextStyle(
                          fontFamily: 'Dubai',
                        ),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        decoration: const InputDecoration(
                          hintText: 'أدخل نص المنشور\n\n',
                          hintStyle: TextStyle(
                            fontFamily: 'Dubai',
                            color: Colors.grey,
                          ),
                          border: null,
                        ),
                      ),

                      // DropdownButton
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'الصور المرفقة',
                          style: TextStyle(
                            fontFamily: 'Dubai',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          child: Row(
                            children: attachedImages
                                .asMap()
                                .entries
                                .map(
                                  (entry) => Stack(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        margin:
                                            const EdgeInsets.only(right: 8.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          image: DecorationImage(
                                            image: FileImage(File(entry.value)),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 4.0,
                                        left: 4.0,
                                        child: GestureDetector(
                                          onTap: () {
                                            // Handle delete action
                                            setState(() {
                                              attachedImages
                                                  .removeAt(entry.key);
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(4.0),
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        if (attachedImages.isEmpty)
                          const Text('لا توجد صور مرفقة'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'الملفات المرفقة',
                          style: TextStyle(
                            fontFamily: 'Dubai',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        // Use a ListView with horizontal scroll
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          child: Row(
                            children: attachedFiles
                                .asMap()
                                .entries
                                .map(
                                  (entry) => Card(
                                    color: Colors.white,
                                    surfaceTintColor: Colors.white,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                attachedFiles
                                                    .removeAt(entry.key);
                                              });
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          Text(
                                            entry.value.split('/').last,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: 'Dubai',
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(width: 2.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),

                        if (attachedFiles.isEmpty)
                          const Text('لا توجد ملفات مرفقة'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
// ...

                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      // Show image picker modal
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ListTile(
                                    leading: const Icon(Icons.camera_alt),
                                    title: const Text('ألتقط صورة'),
                                    onTap: () async {
                                      // Handle capturing a photo from the camera
                                      Navigator.pop(context); // Close modal

                                      final XFile? image =
                                          await ImagePicker().pickImage(
                                        source: ImageSource.camera,
                                      );

                                      if (image != null) {
                                        String imagePathInAssets =
                                            await _copyImageToAssets(
                                                image.path);
                                        setState(() {
                                          // Store the copied image path in the assets/gallery folder
                                          attachedImages.add(imagePathInAssets);
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ListTile(
                                    leading: const Icon(Icons.image),
                                    title: const Text('أختر من الاستوديو'),
                                    onTap: () async {
                                      // Handle choosing from the gallery
                                      Navigator.pop(context); // Close modal

                                      final XFile? image =
                                          await ImagePicker().pickImage(
                                        source: ImageSource.gallery,
                                      );

                                      if (image != null) {
                                        String imagePathInAssets =
                                            await _copyImageToAssets(
                                                image.path);
                                        setState(() {
                                          // Store the copied image path in the assets/gallery folder
                                          attachedImages.add(imagePathInAssets);
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Text(
                      'أضافة صورة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      // Show file picker modal
                      // You can use a file picker package or a custom solution based on your requirements
                      // For simplicity, let's assume you have a function `_pickFile` that returns the selected file path
                      String? filePath = await _pickFile();

                      if (filePath != null) {
                        setState(() {
                          // Store the selected file path
                          attachedFiles.add(filePath);
                        });
                      }
                    },
                    child: const Text(
                      'إرفاق ملف',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButton<String>(
                      value: selectedPostType,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPostType = newValue!;
                        });
                      },
                      items: <String>[
                        'إعلان',
                        'ألبوم',
                        'حدث',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _handlePublish(
                        title, content, 'محمد العمري', selectedPostType);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      ' نشر',
                      style: TextStyle(
                        fontFamily: 'Dubai',
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

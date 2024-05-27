import 'package:flutter/material.dart';
import 'package:school_app/screens/calender.dart';
import 'package:school_app/screens/gallery.dart';
import 'package:school_app/screens/login.dart';
import 'package:school_app/screens/quiz%20Screens/quiz.dart';

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({
    super.key,
    // required this.onSelectScreen,
  });

  // final void Function(String identifier) onSelectScreen;

  @override
  Widget build(context) {
    return Drawer(
      backgroundColor: const Color(0xfff0f6f6),
      surfaceTintColor: const Color(0xfff0f6f6),
      child: Column(
        children: [
          SizedBox(
            height: 146,
            child: DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.school,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Text(
                    'Wellcome!',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.directions_bus_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        title: const Text(
                          'المواصلات',
                          style: TextStyle(
                            fontFamily: 'Dubai',
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  const CalendarScreen(), // put the tracking here
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const ListTile(
                        leading:  Icon(
                          Icons.more_time_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        title: Text(
                          'حجز موعد',
                          style: TextStyle(
                            fontFamily: 'Dubai',
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  PhotoAlbumPage(), // change to alnum screen
                            ),
                          );
                        },
                        leading: const Icon(
                          Icons.photo_library_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        title: const Text(
                          'الألبوم',
                          style: TextStyle(
                            fontFamily: 'Dubai',
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.quiz_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        title: const Text(
                          'الإختبارات',
                          style:TextStyle(
                            fontFamily: 'Dubai',
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => const Quiz(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const ListTile(
                        leading:  Icon(
                          Icons.settings_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        title: Text(
                          'الإعدادات',
                          style: TextStyle(
                            fontFamily: 'Dubai',
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap: () {
                  showLogoutConfirmationDialog(context);
                },
                leading: const Icon(
                  Icons.logout_outlined,
                  color: Colors.red,
                  size: 30,
                ),
                title: const Text(
                  'تسجيل الخروج',
                  style: TextStyle(
                    fontFamily: 'Dubai',
                    color:  Color(0xffff3131),
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceAround,
          title: const Text(
            'تأكيد تسجيل الخروج',
            textAlign: TextAlign.right,
          ),
          content: const Text(
            'هل أنت متأكد أنك تريد تسجيل الخروج؟',
            textAlign: TextAlign.right,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text('نعم'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('لا'),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/chat/pages/home_page.dart';
import 'package:school_app/screens/calender.dart';
import 'package:school_app/screens/home.dart';
//import 'package:school_app/screens/messages.dart';
import 'package:school_app/screens/post.dart';
import 'package:school_app/screens/profile.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  static const List<Widget> _widgetOptions = <Widget>[
    ProfileScreen(),
    CalendarScreen(),
    PostScreen(),
    HomePage(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: Duration.zero,
      length: 5,
      initialIndex: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F6F6),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: _widgetOptions,
        ),
        bottomNavigationBar: Material(
          color: Colors.white,
          child: SizedBox(
            height: 70,
            child: TabBar(
              unselectedLabelColor: Colors.grey,
              physics: const NeverScrollableScrollPhysics(),
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
              labelStyle: const TextStyle(
                fontFamily: 'Dubai',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'Dubai',
                fontSize: 12,
              ),
              indicator: RoundedTopIndicator(),
              isScrollable: false,
              labelColor: Colors.red,
              tabs: const <Widget>[
                Tab(
                  iconMargin: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.account_circle_outlined,
                    size: 35,
                  ),
                  text: ' الشخصي',
                ),
                Tab(
                  iconMargin: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    size: 35,
                  ),
                  text: ' التقويم',
                ),
                Tab(
                  iconMargin: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.add_circle_outline_rounded,
                    size: 35,
                  ),
                  text: 'إضافة',
                ),
                Tab(
                  iconMargin: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.message_outlined,
                    size: 35,
                  ),
                  text: 'المحادثات',
                ),
                Tab(
                  iconMargin: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.home_outlined,
                    size: 35,
                  ),
                  text: " الرئيسية",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedTopIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _RoundedTopIndicatorBoxPainter();
  }
}

class _RoundedTopIndicatorBoxPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3
      ..isAntiAlias = true;

    double indicatorWidth = cfg.size!.width;
    double indicatorHeight = 3.0; // Adjust the height as needed
    double indicatorRadius = 10.0; // Adjust the radius as needed

    // Adjust the offset to position the indicator at the top
    double yOffset = offset.dy - indicatorHeight + 3;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(offset.dx, yOffset),
          Offset(offset.dx + indicatorWidth, yOffset + indicatorHeight),
        ),
        Radius.circular(indicatorRadius),
      ),
      paint,
    );
  }
}

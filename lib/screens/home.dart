import 'dart:async';

import 'package:flutter/material.dart';
import 'package:school_app/data/dummy_data.dart';
import 'package:school_app/models/card_home_info.dart';
import 'package:school_app/widgets/home_card.dart';
import 'package:school_app/widgets/filter_bar_home.dart';
import 'package:school_app/widgets/sidebar_menu.dart';
// ignore: depend_on_referenced_packages
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';

bool isExpanded = false; // Move this line outside the _HomeScreen class
Map<String, bool> sectionExpansionStates = {
  'اليوم': false,
  'أمس': false,
  'الأيام السابقة': false,
};

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  bool _scrollParent = false;
  late TabController _tabController;

  String selectedFilter = 'all';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, bool> filterButtonSelectedState = {
    'all': true,
    'pinned': false,
    'unread': false,
    'announcment': false,
    'Bills': false,
    'Gallery': false,
  };

  final List<Map<String, String>> imageDescriptions = [
    {
      'url':
          'https://www.thegardnerschool.com/wp-content/uploads/2020/01/shutterstock_545206177.jpg',
      'title': 'Image 1',
      'description': 'A beautiful landscape',
    },
    {
      'url':
          'https://www.familyeducation.com/sites/default/files/styles/desktop_jpeg_fallback/public/2023-01/Activities%20That%20Foster%20Your%20Child%27s%20Willingness%20to%20Learn_Feature.jpg?itok=23TMtI_s',
      'title': 'Image 2',
      'description': 'City skyline at night',
    },
    {
      'url':
          'https://www.momjunction.com/wp-content/uploads/2014/10/Dough-Art.jpg',
      'title': 'Image 3',
      'description': 'Mountains covered in snow',
    },
  ];

  // Add a function to handle filter selection
  void handleFilterSelection(String filter) {
    setState(() {
      selectedFilter = filter;
      filterButtonSelectedState.forEach((key, value) {
        filterButtonSelectedState[key] = key == filter;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xFFF0F6F6),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0092FF),
          title: const Align(
            alignment: Alignment.centerRight,
            child: Text(
              "الأخبار والأعلانات",
              style: TextStyle(
                fontFamily: 'Dubai',
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: FilterBarHome(
              onFilterSelected: handleFilterSelection,
              selectedFilter: selectedFilter,
            ),
          ),
          leadingWidth: 60,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 4),
            child: ElevatedButton(
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                backgroundColor: const Color(0xFFF0F6F6),
                surfaceTintColor: const Color(0xFFF0F6F6),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(0),
                    right: Radius.circular(100),
                  ),
                ),
                padding: const EdgeInsets.all(0),
              ),
              child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/temps.png'),
                  radius: 20,
                  child: Icon(
                    Icons.person_outlined,
                  )),
            ),
          ),
        ),
        drawer: const SideBarMenu(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 175, // Adjust the height according to your needs
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: false,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayOnTouch: true,
                    aspectRatio: 16 / 9,
                  ),
                  items: imageDescriptions.map((imageInfo) {
                    final url = imageInfo['url'];
                    final title = imageInfo['title'];
                    final description = imageInfo['description'];

                    return Builder(
                      builder: (BuildContext context) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(
                                  url!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.9),
                                      ],
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        title ?? '',
                                        style: const TextStyle(
                                          fontFamily: 'Dubai',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        description ?? '',
                                        style: const TextStyle(
                                          fontFamily: 'Dubai',
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      // Navigate to the image details page here
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10),
              DefaultTabController(
                length: 3,
                initialIndex: 2,
                child: Column(
                  children: [
                    const TabBar(
                      labelStyle: TextStyle(
                        fontFamily: 'Dubai',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: [
                        Tab(text: 'الأيام السابقة'),
                        Tab(text: 'أمس'),
                        Tab(text: 'اليوم'),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 350,
                      child: TabBarView(
                        children: [
                          _buildSection('الأيام السابقة', dummyCardHomeData),
                          _buildSection('أمس', dummyCardHomeData),
                          _buildSection('اليوم', dummyCardHomeData),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  bool isExpanded = false; // Move this line outside the _buildSection method

  Widget _buildSection(String sectionTitle, List<CardHomeInfo> cardDataList) {
    // Filter cardDataList based on the sectionTitle
    List<CardHomeInfo> filteredCardDataList = cardDataList.where((cardData) {
      return (sectionTitle == 'اليوم' && isToday(cardData.dateTime)) ||
          (sectionTitle == 'أمس' && isYesterday(cardData.dateTime)) ||
          (sectionTitle == 'الأيام السابقة' &&
              !isToday(cardData.dateTime) &&
              !isYesterday(cardData.dateTime));
    }).toList();

    // Check if there are no posts for the specified day
    bool noPostsForDay = filteredCardDataList.isEmpty;

    return IgnorePointer(
      ignoring: _scrollParent,
      child: NotificationListener<OverscrollNotification>(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display "No posts here yet" message if there are no posts for the specified day
              if (noPostsForDay)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    textAlign: TextAlign.center,
                    'لا توجد منشورات هنا حاليا',
                    style: TextStyle(
                      fontFamily: 'Dubai',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              // Build HomeCard widgets if there are posts for the specified day
              for (var cardData in filteredCardDataList.reversed)
                if (selectedFilter == 'all' ||
                    cardData.cardType == selectedFilter ||
                    (selectedFilter == 'unread' && !cardData.isRead) ||
                    (selectedFilter == 'pinned' && cardData.isPinned))
                  HomeCard(
                    index: cardDataList.indexOf(cardData),
                    title: cardData.title,
                    content: cardData.content,
                    author: cardData.author,
                    dateTime: cardData.dateTime,
                    cardType: cardData.cardType,
                    isRead: cardData.isRead,
                    isPinned: cardData.isPinned,
                    images: cardData.images,
                    files: cardData.files,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  bool isToday(DateTime dateTime) {
    // Get the current date without the time
    DateTime currentDate = DateTime.now().toLocal();

    // Format the input date without the time
    String formattedInputDate = DateFormat('yyyy-MM-dd').format(dateTime);

    // Format the current date without the time
    String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);

    // Compare the formatted dates
    return formattedInputDate == formattedCurrentDate;
  }

  bool isYesterday(DateTime dateTime) {
    // Get the current date without the time
    DateTime currentDate = DateTime.now().toLocal();

    // Get the date of yesterday
    DateTime yesterdayDate = currentDate.subtract(const Duration(days: 1));

    // Format the input date without the time
    String formattedInputDate = DateFormat('yyyy-MM-dd').format(dateTime);

    // Format yesterday's date without the time
    String formattedYesterdayDate =
        DateFormat('yyyy-MM-dd').format(yesterdayDate);

    // Compare the formatted dates
    return formattedInputDate == formattedYesterdayDate;
  }
}






// foregroundDecoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(10),
                        //   gradient: LinearGradient(
                        //     begin: Alignment.topCenter,
                        //     end: Alignment.bottomCenter,
                        //     colors: [
                        //       Colors.transparent,
                        //       Colors.black.withOpacity(0.7),
                        //     ],
                        //   ),
                        // ),
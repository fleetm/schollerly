import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/data/dummy_data.dart';
import 'package:school_app/models/message_card_info.dart';
import 'package:school_app/widgets/fillter_bar_messages.dart';
import 'package:school_app/widgets/message_card.dart';
import 'package:school_app/widgets/sidebar_menu.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreen();
}

class _MessagesScreen extends State<MessagesScreen> {
  String selectedFilter = 'all';
  final searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, bool> filterButtonSelectedState = {
    'all': true,
    'groups': false,
    'chats': false,
  };
  

  List<CardMessagesInfo> filteredCards = dummyCardMessagesData;
  bool isSearching = false;

  void handleFilterSelection(String filter) {
    setState(() {
      selectedFilter = filter;
      filterButtonSelectedState.forEach((key, value) {
        filterButtonSelectedState[key] = key == filter;
      });
    });
  }

  void handleSearch(String query) {
    setState(() {
      if (query.isNotEmpty) {
        isSearching = true;
        filteredCards = dummyCardMessagesData
            .where((card) =>
                card.author.toLowerCase().contains(query.trim().toLowerCase()))
            .toList();
      } else {
        isSearching = false;
        filteredCards = dummyCardMessagesData
            .where((card) => card.cardType == selectedFilter)
            .toList();
      }
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xffF0F6F6),
      appBar: AppBar(
        backgroundColor:const  Color(0xFF0092FF),
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "الرسائل",
            style: GoogleFonts.notoSansArabic(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: FilterBarMessages(
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
                  left: Radius.circular(0), // Sharp corner on the left
                  right: Radius.circular(100), // Rounded corner on the right
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
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  controller: searchController,
                  onChanged: handleSearch,
                  onSubmitted: handleSearch,
                  
                  textAlign: TextAlign.right, 
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: 'أبحث بواسطة الاسم',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
              ),
            ),
            for (var cardData in isSearching ? filteredCards : dummyCardMessagesData)
              if (selectedFilter == 'all' ||
                  cardData.cardType == selectedFilter)
                MessageCard(
                  content: cardData.content,
                  author: cardData.author,
                  dateTime: cardData.dateTime,
                  cardType: cardData.cardType,
                ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_app/widgets/calender/flutter_neat_and_clean_calendar.dart';
import 'package:school_app/widgets/sidebar_menu.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  String selectedAttendance = 'حاضر';
  DateTime selectedDay = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF0F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0092FF),
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "التقويم",
            style: TextStyle(
              fontFamily: 'Dubai',
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
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
      body: Column(
        children: [
          Expanded(
            child: Card(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              color: Colors.white,
              surfaceTintColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Calendar(
                  startOnMonday: true,
                  weekDays: const ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'],
                  eventsList: _eventList,
                  isExpandable: true,
                  defaultDayColor: Colors.black,
                  eventDoneColor: Colors.green,
                  selectedColor: Colors.pink,
                  selectedTodayColor: Colors.red,
                  todayColor: Colors.blue,
                  eventColor: Colors.blue,
                  onDateSelected: (selectedDate) {
                    setState(() {
                      selectedDay = selectedDate;
                      selectedAttendance = _getAttendanceStatus(selectedDay);
                    });
                  },
                  locale: 'en_US',
                  todayButtonText: 'Today',
                  allDayEventText: 'All day event',
                  multiDayEndText: 'Event ends',
                  isExpanded: true,
                  expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                  datePickerType: DatePickerType.date,
                  dayOfWeekStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: ElevatedButton(
              onPressed: () {
                _showAttendanceDialog(selectedDay);
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
                  'تسجيل الحضور',
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
    );
  }

  void _showAttendanceDialog(DateTime selectedDay) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "سجل الحضور ليوم ${DateFormat('dd/MM/yyyy').format(selectedDay)}",
            style: const TextStyle(
              fontFamily: 'Dubai',
            ),
            textAlign: TextAlign.right,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "حاضر",
                      style: TextStyle(
                        fontFamily: 'Dubai',
                        color: selectedAttendance == "حاضر"
                            ? Colors.green
                            : Colors.black,
                        fontSize: 22,
                      ),
                    ),
                    selectedAttendance == "حاضر"
                        ? const SizedBox(
                            width: 10,
                          )
                        : const SizedBox(
                            width: 0,
                          ),
                    if (selectedAttendance == "حاضر")
                      const Icon(Icons.check, color: Colors.green),
                  ],
                ),
                onTap: () {
                  setState(() {
                    if (selectedAttendance != "حاضر") {
                      selectedAttendance = "حاضر";
                      _eventList.removeWhere(
                        (event) =>
                            event.summary == "غائب" &&
                            event.startTime.year == selectedDay.year &&
                            event.startTime.month == selectedDay.month &&
                            event.startTime.day == selectedDay.day,
                      );
                    }
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "غائب",
                      style: TextStyle(
                        fontFamily: 'Dubai',
                        color: selectedAttendance == "غائب"
                            ? Colors.red
                            : Colors.black,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    selectedAttendance == "غائب"
                        ? const SizedBox(
                            width: 10,
                          )
                        : const SizedBox(
                            width: 0,
                          ),
                    if (selectedAttendance == "غائب")
                      const Icon(Icons.check, color: Colors.red),
                  ],
                ),
                onTap: () {
                  setState(() {
                    if (selectedAttendance != "غائب") {
                      selectedAttendance = "غائب";
                      _eventList.add(
                        NeatCleanCalendarEvent(
                          "غائب",
                          startTime: selectedDay,
                          endTime: selectedDay,
                          color: Colors.red,
                          isAllDay: true,
                        ),
                      );
                    }
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _getAttendanceStatus(DateTime selectedDay) {
    bool isAbsent = _eventList.any((event) =>
        event.summary == "غائب" &&
        event.startTime.year == selectedDay.year &&
        event.startTime.month == selectedDay.month &&
        event.startTime.day == selectedDay.day);

    return isAbsent ? "غائب" : "حاضر";
  }
}

final List<NeatCleanCalendarEvent> _eventList = [
  NeatCleanCalendarEvent(
    'MultiDay Event A',
    startTime: DateTime.now().subtract(const Duration(days: 1)),
    endTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
    color: Colors.orange,
    isMultiDay: true,
  ),
  NeatCleanCalendarEvent(
    'All day Event B',
    startTime: DateTime.now().subtract(const Duration(days: 2)),
    endTime: DateTime.now().add(const Duration(days: 2, hours: 2)),
    color: Colors.pink,
    isAllDay: true,
  ),
  NeatCleanCalendarEvent(
    'Normal Event D',
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 2)),
    color: Colors.indigo,
  ),
];

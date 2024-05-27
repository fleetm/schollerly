import 'package:flutter/material.dart';
import 'package:school_app/widgets/quiz/summary_item.dart';

class QusertionsSammaryScreen extends StatelessWidget {
  const QusertionsSammaryScreen(this.sammaryData, {super.key});

  final List<Map<String, Object>> sammaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: sammaryData.map(
            (data) {
              return SummaryItem(data);
            },
          ).toList(),
        ),
      ),
    );
  }
}

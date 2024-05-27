import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/widgets/quiz/question_identifier.dart';


class SummaryItem extends StatelessWidget {
  const SummaryItem(this.itemData, {super.key});

  final Map<String, Object> itemData;

  @override
  Widget build(BuildContext context) {
    final isCorrectAnswer =
        itemData['uesr_answer'] == itemData['correct_answer'];

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    itemData['question'] as String,
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(itemData['uesr_answer'] as String,
                      style:  TextStyle(
                        color: isCorrectAnswer? Colors.blue: Colors.red,
                      )),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(itemData['correct_answer'] as String,
                      style: const TextStyle(
                        color: Colors.green,
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          QuestionIdentifier(
            isCorrectAnswer: isCorrectAnswer,
            questionIndex: itemData['question_index'] as int,
          ),
        ],
      ),
    );
  }
}
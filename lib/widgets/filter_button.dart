import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isSelected;

  const FilterButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isSelected,
  });

    @override
    Widget build(BuildContext context) {
      return TextButton(
        onPressed: () => onPressed(),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            isSelected ? const Color(0xfff0f6f6) : Colors.transparent,
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.notoSansArabic(),
        ),
      );
    }
  }

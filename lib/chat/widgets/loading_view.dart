import 'package:flutter/material.dart';
import 'package:school_app/chat/constants/color_constants.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.8),
      child: const Center(
        child: CircularProgressIndicator(
          color: ColorConstants.themeColor,
        ),
      ),
    );
  }
}

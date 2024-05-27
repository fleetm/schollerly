import 'package:flutter/material.dart';

class ProfileOption extends StatelessWidget {
  const ProfileOption({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Dubai',
            ),
          ),
          const SizedBox(width: 8),
          icon,
        ],
      ),
    );
  }
}

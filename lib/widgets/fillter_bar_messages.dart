import 'package:flutter/material.dart';
import 'package:school_app/widgets/filter_button.dart';

class FilterBarMessages extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const FilterBarMessages({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(
          width: 14,
        ),
        FilterButton(
          text: 'المحادثات',
          onPressed: () => onFilterSelected('chat'),
          isSelected: selectedFilter == 'chat',
        ),
        FilterButton(
          text: 'المجموعات',
          onPressed: () => onFilterSelected('group'),
          isSelected: selectedFilter == 'group',
        ),
        FilterButton(
          text: 'الكل',
          onPressed: () => onFilterSelected('all'),
          isSelected: selectedFilter == 'all',
        ),
        const SizedBox(
          width: 14,
        ),
      ],
    );
  }
}

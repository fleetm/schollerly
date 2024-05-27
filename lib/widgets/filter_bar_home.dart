import 'package:flutter/material.dart';
import 'package:school_app/widgets/filter_button.dart';

class FilterBarHome extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const FilterBarHome({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            width: 14,
          ),
          FilterButton(
            text: 'الألبومات',
            onPressed: () => onFilterSelected('ألبوم'),
            isSelected: selectedFilter == 'ألبوم',
          ),
          FilterButton(
            text: 'الأحداث',
            onPressed: () => onFilterSelected('حدث'),
            isSelected: selectedFilter == 'حدث',
          ),
          FilterButton(
            text: 'الأعلانات',
            onPressed: () => onFilterSelected('إعلان'),
            isSelected: selectedFilter == 'إعلان',
          ),
          FilterButton(
            text: 'الغير مقروءة',
            onPressed: () => onFilterSelected('unread'),
            isSelected: selectedFilter == 'unread',
          ),
          FilterButton(
            text: 'المثبته',
            onPressed: () => onFilterSelected('pinned'),
            isSelected: selectedFilter == 'pinned',
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
      ),
    );
  }
}

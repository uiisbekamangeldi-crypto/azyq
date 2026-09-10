import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class CategoryChipsWidget extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryChipsWidget({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  static const List<Map<String, dynamic>> _categories = [
    {'label': 'Все', 'icon': Icons.apps_rounded},
    {'label': 'Овощи', 'icon': Icons.eco_rounded},
    {'label': 'Фрукты', 'icon': Icons.apple_rounded},
    {'label': 'Молочное', 'icon': Icons.water_drop_outlined},
    {'label': 'Мясо', 'icon': Icons.restaurant_menu_rounded},
    {'label': 'Зерно', 'icon': Icons.grass_rounded},
    {'label': 'Домашнее', 'icon': Icons.home_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final isSelected = selectedCategory == cat['label'];

          return GestureDetector(
            onTap: () => onCategorySelected(cat['label'] as String),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primary : AppTheme.surfaceLight,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? AppTheme.primary.withAlpha(77)
                        : Colors.black.withAlpha(13),
                    blurRadius: isSelected ? 10 : 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    cat['icon'] as IconData,
                    size: 16,
                    color: isSelected ? Colors.white : const Color(0xFF4A5E4C),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    cat['label'] as String,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF4A5E4C),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

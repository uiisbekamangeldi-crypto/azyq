import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class MarketplaceFilterWidget extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const MarketplaceFilterWidget({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  static const List<Map<String, dynamic>> _filters = [
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
    return Container(
      color: AppTheme.backgroundLight,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 38,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _filters.length,
          itemBuilder: (context, index) {
            final filter = _filters[index];
            final isSelected = selectedFilter == filter['label'];

            return GestureDetector(
              onTap: () => onFilterSelected(filter['label'] as String),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primary : AppTheme.surfaceLight,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected
                          ? AppTheme.primary.withAlpha(64)
                          : Colors.black.withAlpha(10),
                      blurRadius: isSelected ? 8 : 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      filter['icon'] as IconData,
                      size: 14,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF4A5E4C),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      filter['label'] as String,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
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
      ),
    );
  }
}

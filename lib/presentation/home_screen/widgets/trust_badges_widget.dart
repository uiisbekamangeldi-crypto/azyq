import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class TrustBadgesWidget extends StatelessWidget {
  const TrustBadgesWidget({super.key});

  static const List<Map<String, dynamic>> _badges = [
    {
      'icon': Icons.verified_rounded,
      'label': '100% Натуральное',
      'color': Color(0xFF2D7A3A),
    },
    {
      'icon': Icons.security_rounded,
      'label': 'Безопасная оплата',
      'color': Color(0xFF1565C0),
    },
    {
      'icon': Icons.public_rounded,
      'label': 'Доставка по СНГ',
      'color': Color(0xFFB45309),
    },
    {
      'icon': Icons.support_agent_rounded,
      'label': 'Поддержка 24/7',
      'color': Color(0xFF5B21B6),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _badges.map((badge) {
          return Column(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: (badge['color'] as Color).withAlpha(26),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  badge['icon'] as IconData,
                  color: badge['color'] as Color,
                  size: 20,
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: 64,
                child: Text(
                  badge['label'] as String,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4A5E4C),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

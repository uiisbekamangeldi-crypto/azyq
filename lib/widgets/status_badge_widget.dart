import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum BadgeStatus {
  active,
  pending,
  delivered,
  fresh,
  organic,
  certified,
  outOfStock,
  warning,
}

class StatusBadgeWidget extends StatelessWidget {
  final BadgeStatus status;
  final String? customLabel;
  final double fontSize;

  const StatusBadgeWidget({
    super.key,
    required this.status,
    this.customLabel,
    this.fontSize = 11,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: config.bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        customLabel ?? config.label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: config.textColor,
        ),
      ),
    );
  }

  _BadgeConfig _getConfig(BadgeStatus status) {
    switch (status) {
      case BadgeStatus.active:
        return _BadgeConfig(
          label: 'Активно',
          bgColor: const Color(0xFFD4EDDA),
          textColor: const Color(0xFF1B5E27),
        );
      case BadgeStatus.pending:
        return _BadgeConfig(
          label: 'Ожидание',
          bgColor: const Color(0xFFFFF3CD),
          textColor: const Color(0xFF856404),
        );
      case BadgeStatus.delivered:
        return _BadgeConfig(
          label: 'Доставлено',
          bgColor: const Color(0xFFCFE2FF),
          textColor: const Color(0xFF084298),
        );
      case BadgeStatus.fresh:
        return _BadgeConfig(
          label: 'Свежее',
          bgColor: const Color(0xFFD1FAE5),
          textColor: const Color(0xFF065F46),
        );
      case BadgeStatus.organic:
        return _BadgeConfig(
          label: 'Эко',
          bgColor: const Color(0xFFD4EDDA),
          textColor: const Color(0xFF2D7A3A),
        );
      case BadgeStatus.certified:
        return _BadgeConfig(
          label: 'Сертифицировано',
          bgColor: const Color(0xFFE8D5FF),
          textColor: const Color(0xFF5B21B6),
        );
      case BadgeStatus.outOfStock:
        return _BadgeConfig(
          label: 'Нет в наличии',
          bgColor: const Color(0xFFFEE2E2),
          textColor: const Color(0xFF991B1B),
        );
      case BadgeStatus.warning:
        return _BadgeConfig(
          label: 'Внимание',
          bgColor: const Color(0xFFFEF3C7),
          textColor: const Color(0xFFB45309),
        );
    }
  }
}

class _BadgeConfig {
  final String label;
  final Color bgColor;
  final Color textColor;

  _BadgeConfig({
    required this.label,
    required this.bgColor,
    required this.textColor,
  });
}

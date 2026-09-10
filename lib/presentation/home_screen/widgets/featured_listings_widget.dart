import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class FeaturedListingsWidget extends StatelessWidget {
  final bool isTablet;
  final VoidCallback onSeeAll;

  const FeaturedListingsWidget({
    super.key,
    required this.isTablet,
    required this.onSeeAll,
  });

  static final List<Map<String, dynamic>> _featuredMaps = [
    {
      'name': 'Помидоры черри',
      'seller': 'Айгерим С.',
      'price': '600',
      'unit': 'кг',
      'location': 'Алматы',
      'imageUrl':
          'https://images.unsplash.com/photo-1618345525719-ba5935ab907e',
      'semanticLabel':
          'Cluster of ripe red cherry tomatoes on green vine, fresh and glossy',
      'badge': 'Свежее',
      'isOrganic': true,
      'rating': '4.8',
    },
    {
      'name': 'Домашний айран',
      'seller': 'Зауре А.',
      'price': '350',
      'unit': 'л',
      'location': 'Шымкент',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_1da2ccbc6-1766170645480.png',
      'semanticLabel':
          'Traditional Kazakh ayran in white ceramic bowl with blue pattern, frothy white fermented milk drink',
      'badge': 'Домашнее',
      'isOrganic': true,
      'rating': '4.9',
    },
    {
      'name': 'Картофель синеглазка',
      'seller': 'Бекзат Н.',
      'price': '180',
      'unit': 'кг',
      'location': 'Костанай',
      'imageUrl':
          'https://images.unsplash.com/photo-1645031039066-73614f35a856',
      'semanticLabel':
          'Pile of fresh harvested potatoes with dirt still on skin, natural organic look',
      'badge': 'Акция',
      'isOrganic': false,
      'rating': '4.6',
    },
    {
      'name': 'Курт домашний',
      'seller': 'Гулмира Т.',
      'price': '2400',
      'unit': 'кг',
      'location': 'Туркестан',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_4c956e76c-1788973943458.png',
      'semanticLabel':
          'Traditional Kazakh kurt dried salted cheese balls arranged in wooden bowl',
      'badge': 'Топ',
      'isOrganic': true,
      'rating': '5.0',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Популярные товары',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A2B1C),
                ),
              ),
              GestureDetector(
                onTap: onSeeAll,
                child: Text(
                  'Все →',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: isTablet ? 220 : 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _featuredMaps.length,
            itemBuilder: (context, index) {
              final item = _featuredMaps[index];
              return _buildFeaturedCard(context, item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedCard(BuildContext context, Map<String, dynamic> item) {
    return Container(
      width: 148,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border(
          left: BorderSide(
            color: item['isOrganic'] == true
                ? AppTheme.primary
                : AppTheme.secondary,
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(13),
              topRight: Radius.circular(16),
            ),
            child: Stack(
              children: [
                CustomImageWidget(
                  imageUrl: item['imageUrl'] as String,
                  width: 148,
                  height: 100,
                  fit: BoxFit.cover,
                  semanticLabel: item['semanticLabel'] as String,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: item['isOrganic'] == true
                          ? AppTheme.primary
                          : AppTheme.secondary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item['badge'] as String,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A2B1C),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 10,
                      color: Color(0xFF9E9E9E),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        item['location'] as String,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          color: const Color(0xFF9E9E9E),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item['price']} ₸/${item['unit']}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.primary,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 11,
                          color: AppTheme.secondary,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          item['rating'] as String,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4A5E4C),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

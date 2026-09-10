import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class NewArrivalsWidget extends StatelessWidget {
  final bool isTablet;

  const NewArrivalsWidget({super.key, required this.isTablet});

  static final List<Map<String, dynamic>> _arrivalsMaps = [
    {
      'name': 'Яблоки апорт',
      'price': '450',
      'unit': 'кг',
      'imageUrl':
          'https://images.unsplash.com/photo-1588582565951-6caa6f65ba84',
      'semanticLabel':
          'Red apples Aport variety from Kazakhstan piled in wooden crate, autumn harvest',
      'seller': 'Нурлан О.',
      'isNew': true,
    },
    {
      'name': 'Тыква сорт Хоккайдо',
      'price': '250',
      'unit': 'кг',
      'imageUrl':
          'https://images.unsplash.com/photo-1729368715986-d1bf887f5ef1',
      'semanticLabel':
          'Orange Hokkaido pumpkins arranged in rows at autumn farmers market display',
      'seller': 'Мадина К.',
      'isNew': true,
    },
    {
      'name': 'Мёд акациевый',
      'price': '3200',
      'unit': 'л',
      'imageUrl':
          'https://images.unsplash.com/photo-1603445215995-fb465c635535',
      'semanticLabel':
          'Glass jar of golden acacia honey with wooden honey dipper on rustic wooden surface',
      'seller': 'Серік Б.',
      'isNew': false,
    },
    {
      'name': 'Морковь Нантская',
      'price': '200',
      'unit': 'кг',
      'imageUrl':
          'https://images.unsplash.com/photo-1629119886251-e885f4b83539',
      'semanticLabel':
          'Bunch of fresh orange Nantes carrots with green tops on white background',
      'seller': 'Алма Д.',
      'isNew': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = isTablet ? 3 : 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Новые поступления',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A2B1C),
                ),
              ),
              Text(
                'Все →',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.82,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: _arrivalsMaps.length,
            itemBuilder: (context, index) {
              return _buildArrivalCard(_arrivalsMaps[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildArrivalCard(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CustomImageWidget(
                    imageUrl: item['imageUrl'] as String,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    semanticLabel: item['semanticLabel'] as String,
                  ),
                  if (item['isNew'] == true)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.secondary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'НОВОЕ',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 8,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
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
                Text(
                  item['seller'] as String,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: const Color(0xFF9E9E9E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item['price']} ₸/${item['unit']}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primary,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

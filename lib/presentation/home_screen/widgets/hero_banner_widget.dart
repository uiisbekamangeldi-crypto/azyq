import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class HeroBannerWidget extends StatefulWidget {
  const HeroBannerWidget({super.key});

  @override
  State<HeroBannerWidget> createState() => _HeroBannerWidgetState();
}

class _HeroBannerWidgetState extends State<HeroBannerWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // TODO: Replace with [Riverpod/Bloc] for production
  final List<Map<String, String>> _banners = [
    {
      'title': 'Свежие овощи\nпрямо с грядки',
      'subtitle': 'Скидка 20% на первый заказ',
      'imageUrl':
          'https://images.unsplash.com/photo-1730984226564-9acca316af6e',
      'semanticLabel':
          'Fresh vegetables including tomatoes and cucumbers arranged on wooden table in garden setting',
      'cta': 'Купить сейчас',
    },
    {
      'title': 'Домашние\nмолочные продукты',
      'subtitle': 'Айран, сливки, курт — всё натуральное',
      'imageUrl':
          'https://images.unsplash.com/photo-1559561853-08451507cbe7',
      'semanticLabel':
          'Traditional Kazakh dairy products in ceramic bowls with fresh herbs on rustic surface',
      'cta': 'Смотреть',
    },
    {
      'title': 'Осенний урожай\nпшеницы',
      'subtitle': 'Прямые поставки от фермеров',
      'imageUrl':
          'https://images.unsplash.com/photo-1685219037967-d4b84b644143',
      'semanticLabel':
          'Golden wheat field at sunset with rows of crops extending to horizon in Kazakhstan steppe',
      'cta': 'Оптовые цены',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemCount: _banners.length,
              itemBuilder: (context, index) {
                return _buildBannerCard(_banners[index]);
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _banners.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: _currentPage == i ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: _currentPage == i
                      ? AppTheme.primary
                      : AppTheme.primary.withAlpha(77),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCard(Map<String, String> banner) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withAlpha(51),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomImageWidget(
              imageUrl: banner['imageUrl']!,
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
              semanticLabel: banner['semanticLabel']!,
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [Colors.transparent, Colors.black.withAlpha(179)],
                ),
              ),
            ),
            // Content
            Positioned(
              left: 20,
              bottom: 20,
              right: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    banner['subtitle']!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.secondary,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    banner['title']!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.secondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      banner['cta']!,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Eco badge
            Positioned(
              top: 14,
              right: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.eco_rounded,
                      color: Colors.white,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Эко',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

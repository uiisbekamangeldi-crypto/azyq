import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_theme.dart';
import './widgets/add_listing_sheet_widget.dart';
import './widgets/marketplace_filter_widget.dart';
import './widgets/marketplace_search_bar_widget.dart';
import './widgets/product_list_card_widget.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen>
    with TickerProviderStateMixin {
  // TODO: Replace with [Riverpod/Bloc] for production
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'Все';
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _listingsMaps = [
{ 'id': 'L001',
'name': 'Помидоры Бычье сердце',
'category': 'Овощи',
'seller': 'Айгерим Сейткали',
'sellerRating': '4.9',
'location': 'Алматы обл.',
'price': '650',
'unit': 'кг',
'minOrder': '5',
'imageUrl': 'https://img.rocket.new/generatedImages/rocket_gen_img_11208ccdd-1772906147309.png',
'semanticLabel': 'Large beefsteak tomatoes variety red ripe on green plant vine, farm fresh',
'isOrganic': true,
'isFresh': true,
'stock': '120',
'postedAgo': '2 ч назад',
'isDark': false,
},
{ 'id': 'L002',
'name': 'Пшеница озимая 1 сорт',
'category': 'Зерно',
'seller': 'КХ Береке',
'sellerRating': '4.7',
'location': 'Костанайская обл.',
'price': '95',
'unit': 'кг',
'minOrder': '1000',
'imageUrl': 'https://images.unsplash.com/photo-1595048933902-dc47578e16b6',
'semanticLabel': 'Golden wheat field with ripe grain heads in Kazakhstan steppe, summer harvest',
'isOrganic': false,
'isFresh': false,
'stock': '50000',
'postedAgo': '5 ч назад',
'isDark': true,
},
{ 'id': 'L003',
'name': 'Кобыс кымыз',
'category': 'Молочное',
'seller': 'Зауре Ахметова',
'sellerRating': '5.0',
'location': 'Жамбылская обл.',
'price': '1200',
'unit': 'л',
'minOrder': '2',
'imageUrl': 'https://img.rocket.new/generatedImages/rocket_gen_img_16ee52242-1774094423677.png',
'semanticLabel': 'Traditional Kazakh koumiss kumiss fermented mare milk in traditional leather vessel',
'isOrganic': true,
'isFresh': true,
'stock': '30',
'postedAgo': '1 ч назад',
'isDark': false,
},
{ 'id': 'L004',
'name': 'Казы конина',
'category': 'Мясо',
'seller': 'Бекзат Нұрланов',
'sellerRating': '4.8',
'location': 'Шымкент',
'price': '4800',
'unit': 'кг',
'minOrder': '1',
'imageUrl': 'https://img.rocket.new/generatedImages/rocket_gen_img_1081caa8d-1781701781534.png',
'semanticLabel': 'Traditional Kazakh kazy horse meat sausage on wooden cutting board with herbs',
'isOrganic': true,
'isFresh': true,
'stock': '15',
'postedAgo': '3 ч назад',
'isDark': true,
},
{ 'id': 'L005',
'name': 'Огурцы тепличные',
'category': 'Овощи',
'seller': 'Мадина Касымова',
'sellerRating': '4.6',
'location': 'Астана',
'price': '380',
'unit': 'кг',
'minOrder': '3',
'imageUrl': 'https://images.unsplash.com/photo-1642109309502-982e2071574a',
'semanticLabel': 'Fresh green cucumbers in greenhouse with water droplets, vertical garden growing',
'isOrganic': false,
'isFresh': true,
'stock': '200',
'postedAgo': '6 ч назад',
'isDark': false,
},
{ 'id': 'L006',
'name': 'Яблоки Апорт',
'category': 'Фрукты',
'seller': 'Нурлан Оспанов',
'sellerRating': '4.9',
'location': 'Алматы',
'price': '420',
'unit': 'кг',
'minOrder': '5',
'imageUrl': 'https://images.unsplash.com/photo-1630908995490-ec1ec46718af',
'semanticLabel': 'Red Aport apples Kazakhstan variety in wooden box at outdoor farmers market',
'isOrganic': true,
'isFresh': true,
'stock': '500',
'postedAgo': '8 ч назад',
'isDark': true,
},
{ 'id': 'L007',
'name': 'Мёд горный',
'category': 'Домашнее',
'seller': 'Серік Байжанов',
'sellerRating': '4.8',
'location': 'Алтай',
'price': '3500',
'unit': 'кг',
'minOrder': '1',
'imageUrl': 'https://images.unsplash.com/photo-1700798981408-d0f8d6f3029d',
'semanticLabel': 'Dark amber mountain honey in glass jar with wooden dipper dripping honey',
'isOrganic': true,
'isFresh': false,
'stock': '45',
'postedAgo': '12 ч назад',
'isDark': false,
},
{ 'id': 'L008',
'name': 'Картофель Невский',
'category': 'Овощи',
'seller': 'Алма Дюсенова',
'sellerRating': '4.5',
'location': 'Северо-Казахстанская обл.',
'price': '160',
'unit': 'кг',
'minOrder': '10',
'imageUrl': 'https://images.unsplash.com/photo-1695967605341-f16087beab70',
'semanticLabel': 'Freshly harvested Nevsky potatoes in burlap sack on farm soil, autumn harvest',
'isOrganic': false,
'isFresh': true,
'stock': '2000',
'postedAgo': '1 д назад',
'isDark': true,
},
];

  List<Map<String, dynamic>> get _filteredListings {
    return _listingsMaps.where((item) {
      final matchesSearch = _searchQuery.isEmpty ||
          (item['name'] as String)
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          (item['seller'] as String)
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      final matchesFilter = _selectedFilter == 'Все' ||
          item['category'] == _selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _showAddListingSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddListingSheetWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final filtered = _filteredListings;

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: Column(
        children: [
          // Fixed gradient AppBar
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1B5E27), Color(0xFF2D7A3A)],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Рынок Asyq',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(51),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_rounded,
                                  color: Colors.white, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                'Казахстан',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    MarketplaceSearchBarWidget(
                      controller: _searchController,
                      onChanged: (v) =>
                          setState(() => _searchQuery = v),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Filter chips
          MarketplaceFilterWidget(
            selectedFilter: _selectedFilter,
            onFilterSelected: (f) =>
                setState(() => _selectedFilter = f),
          ),
          // Listings count
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Text(
                  '${filtered.length} объявлений',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4A5E4C),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceLight,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: const Color(0xFFBDCABF)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.sort_rounded,
                            size: 14,
                            color: Color(0xFF4A5E4C)),
                        const SizedBox(width: 4),
                        Text(
                          'Сортировка',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF4A5E4C),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Listings list
          Expanded(
            child: filtered.isEmpty
                ? _buildEmptyState()
                : RefreshIndicator(
                    color: AppTheme.primary,
                    onRefresh: () async {
                      // TODO: Replace with actual refresh API call
                      await Future.delayed(
                          const Duration(milliseconds: 800));
                    },
                    child: isTablet
                        ? _buildTabletGrid(filtered)
                        : _buildPhoneList(filtered),
                  ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton.extended(
          onPressed: _showAddListingSheet,
          icon: const Icon(Icons.add_rounded, color: Colors.white),
          label: Text(
            'Добавить товар',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppTheme.primary,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneList(List<Map<String, dynamic>> items) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 120),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: Duration(milliseconds: 300 + (index * 50).clamp(0, 400)),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(opacity: value, child: ProductListCardWidget(
                        item: items[index],
                        onAddToCart: () => showAddedToCartToast(items[index]['name'] as String),
                        onContact: () {},
                      )),
            );
          },
        );
      },
    );
  }

  Widget _buildTabletGrid(List<Map<String, dynamic>> items) {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 120),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.6,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ProductListCardWidget(
          item: items[index],
          onAddToCart: () => showAddedToCartToast(items[index]['name'] as String),
          onContact: () {},
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.storefront_outlined,
              size: 40,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Товары не найдены',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A2B1C),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Попробуйте изменить фильтры\nили поисковый запрос',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: const Color(0xFF4A5E4C),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void showAddedToCartToast(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded,
                color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '$name добавлен в корзину',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.primary,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
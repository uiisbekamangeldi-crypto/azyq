import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

// V4 — Swipeable Action: Dismissible swipe reveals contextual actions — LOCKED
// Alternating light/dark card treatment from Image 2 — LOCKED

class ProductListCardWidget extends StatefulWidget {
  final Map<String, dynamic> item;
  final VoidCallback onAddToCart;
  final VoidCallback onContact;

  const ProductListCardWidget({
    super.key,
    required this.item,
    required this.onAddToCart,
    required this.onContact,
  });

  @override
  State<ProductListCardWidget> createState() => _ProductListCardWidgetState();
}

class _ProductListCardWidgetState extends State<ProductListCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.97,
      upperBound: 1.0,
    )..value = 1.0;
    _scaleAnimation = _pressController;
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  bool get _isDark => widget.item['isDark'] == true;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.item['id']),
      direction: DismissDirection.endToStart,
      background: _buildSwipeBackground(),
      confirmDismiss: (direction) async {
        widget.onAddToCart();
        return false; // don't actually dismiss — just trigger action
      },
      child: GestureDetector(
        onTapDown: (_) => _pressController.reverse(),
        onTapUp: (_) => _pressController.forward(),
        onTapCancel: () => _pressController.forward(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: _isDark ? const Color(0xFF1A2B1C) : AppTheme.surfaceLight,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(_isDark ? 0.2 : 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Product image — left square
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      CustomImageWidget(
                        imageUrl: widget.item['imageUrl'] as String,
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                        semanticLabel: widget.item['semanticLabel'] as String,
                      ),
                      if (widget.item['isOrganic'] == true)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Эко',
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
                // Info column — right
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name + category
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.item['name'] as String,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: _isDark
                                      ? Colors.white
                                      : const Color(0xFF1A2B1C),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        // Seller + location
                        Row(
                          children: [
                            const Icon(
                              Icons.person_outline_rounded,
                              size: 11,
                              color: Color(0xFF9E9E9E),
                            ),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Text(
                                widget.item['seller'] as String,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  color: _isDark
                                      ? Colors.white60
                                      : const Color(0xFF9E9E9E),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 11,
                              color: Color(0xFF9E9E9E),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              widget.item['location'] as String,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                color: _isDark
                                    ? Colors.white60
                                    : const Color(0xFF9E9E9E),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Price row + badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.item['price']} ₸/${widget.item['unit']}',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: _isDark
                                        ? AppTheme.secondary
                                        : AppTheme.primary,
                                    fontFeatures: const [
                                      FontFeature.tabularFigures(),
                                    ],
                                  ),
                                ),
                                Text(
                                  'от ${widget.item['minOrder']} ${widget.item['unit']}',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10,
                                    color: _isDark
                                        ? Colors.white38
                                        : const Color(0xFF9E9E9E),
                                  ),
                                ),
                              ],
                            ),
                            // Arrow CTA — from Image 2 anatomy
                            GestureDetector(
                              onTap: widget.onContact,
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: _isDark
                                      ? Colors.white.withAlpha(38)
                                      : AppTheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  color: _isDark
                                      ? Colors.white
                                      : AppTheme.primary,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeBackground() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.add_shopping_cart_rounded,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            'В корзину',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import './widgets/auth_form_widget.dart';
import './widgets/demo_credentials_widget.dart';
import './widgets/role_selection_card_widget.dart';

enum UserRole { homeSeller, farmer, courier }

class SignUpLoginScreen extends StatefulWidget {
  const SignUpLoginScreen({super.key});

  @override
  State<SignUpLoginScreen> createState() => _SignUpLoginScreenState();
}

class _SignUpLoginScreenState extends State<SignUpLoginScreen>
    with TickerProviderStateMixin {
  // TODO: Replace with [Riverpod/Bloc] for production
  UserRole? _selectedRole;
  bool _isLogin = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRoleSelected(UserRole role) {
    setState(() => _selectedRole = role);
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) return;
    if (_selectedRole == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Выберите роль для регистрации',
            style: GoogleFonts.plusJakartaSans(),
          ),
          backgroundColor: AppTheme.warning,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    // TODO: Replace with actual auth API call
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() => _isLoading = false);

    if (mounted) {
      context.go(AppRoutes.homeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1B5E27), Color(0xFF2D7A3A), Color(0xFF4CAF5C)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: isTablet ? _buildTabletLayout() : _buildPhoneLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Center(child: SizedBox(width: 520, child: _buildScrollContent()));
  }

  Widget _buildPhoneLayout() {
    return _buildScrollContent();
  }

  Widget _buildScrollContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildTabToggle(),
          const SizedBox(height: 20),
          if (!_isLogin) ...[_buildRoleSection(), const SizedBox(height: 20)],
          _buildFormCard(),
          const SizedBox(height: 16),
          DemoCredentialsWidget(
            onUseCredentials: (email, password) {
              _emailController.text = email;
              _passwordController.text = password;
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(51),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.eco_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Asyq',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          _isLogin ? 'Добро\nпожаловать!' : 'Создать\nаккаунт',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -1,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Продавайте свой урожай и домашние продукты по всему Казахстану',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white.withAlpha(204),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildTabToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(38),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _buildToggleTab('Войти', _isLogin, () {
            setState(() => _isLogin = true);
          }),
          _buildToggleTab('Регистрация', !_isLogin, () {
            setState(() => _isLogin = false);
          }),
        ],
      ),
    );
  }

  Widget _buildToggleTab(String label, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isActive ? AppTheme.primary : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Выберите вашу роль',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: RoleSelectionCardWidget(
                role: UserRole.homeSeller,
                icon: Icons.yard_rounded,
                title: 'Огородник',
                subtitle: 'Продаю с огорода',
                isSelected: _selectedRole == UserRole.homeSeller,
                onTap: () => _onRoleSelected(UserRole.homeSeller),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: RoleSelectionCardWidget(
                role: UserRole.farmer,
                icon: Icons.agriculture_rounded,
                title: 'Фермер',
                subtitle: 'Крупное хозяйство',
                isSelected: _selectedRole == UserRole.farmer,
                onTap: () => _onRoleSelected(UserRole.farmer),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: RoleSelectionCardWidget(
                role: UserRole.courier,
                icon: Icons.delivery_dining_rounded,
                title: 'Курьер',
                subtitle: 'Доставка заказов',
                isSelected: _selectedRole == UserRole.courier,
                onTap: () => _onRoleSelected(UserRole.courier),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormCard() {
    return AuthFormWidget(
      formKey: _formKey,
      emailController: _emailController,
      passwordController: _passwordController,
      isLogin: _isLogin,
      isLoading: _isLoading,
      onSubmit: _submit,
    );
  }
}

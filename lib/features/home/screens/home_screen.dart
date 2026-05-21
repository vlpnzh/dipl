import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/common/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import '../../../core/common/widgets/buttons/call_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../gen/assets.gen.dart';
import '../tabs/calculation/calculation_tab.dart';
import '../tabs/capital/capital_tab.dart';
import '../tabs/transactions/transactions_tab.dart';
import '../widgets/balance_widget.dart';
import '../widgets/targets_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isVisible = true;
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child:
              _currentNavIndex == 2
                  ? const ColoredBox(color: AppColors.transactionsScreenBg)
                  : Assets.images.bg.image(fit: BoxFit.cover),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: BottomNavBar(
            currentIndex: _currentNavIndex,
            onTap: (index) => setState(() => _currentNavIndex = index),
            bgColor: AppColors.primaryColor.withAlpha(20),
          ),
          body: _buildTabBody(context),
        ),
      ],
    );
  }

  Widget _buildTabBody(BuildContext context) {
    switch (_currentNavIndex) {
      case 1:
        return const CapitalTab();
      case 2:
        return const TransactionsTab();
      case 3:
        return const CalculationTab();
      default:
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  expandedHeight: 20.h,
                  pinned: false,
                  floating: true,
                  snap: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Вітаємо, Владиславе!', //TODO: Localization
                          style: AppTextStyles.appBar,
                        ),
                        const Spacer(),
                        const CallButton(),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      16.verticalSpace,
                      BalanceWidget(
                        isVisible: _isVisible,
                        onTap: () => setState(() => _isVisible = !_isVisible),
                      ),
                      16.verticalSpace,
                      const TargetsCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }
}

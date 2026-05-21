import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/utils/extensions.dart';
import '../../../../core/common/widgets/buttons/call_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../gen/assets.gen.dart';

class CapitalTab extends StatelessWidget {
  const CapitalTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transactionsScreenBg,
      appBar: AppBar(
        backgroundColor: AppColors.transactionsScreenBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Капітал',
          style: AppTextStyles.appBar.copyWith(color: AppColors.black),
        ),
        actions: [const CallButton()],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              _buildMainProgressCard(context),
              SizedBox(height: 16.h),
              _buildGridCards(context),
              SizedBox(height: 16.h),
              _buildTrendCard(context),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainProgressCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.locale!.currentProgress,
                    style: AppTextStyles.subtitle.copyWith(
                      color: AppColors.white.withAlpha(80),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '₴180000',
                    style: AppTextStyles.amount.copyWith(
                      color: AppColors.white,
                      fontSize: 32.sp,
                    ),
                  ),
                ],
              ),
              Container(
                width: 64.r,
                height: 64.r,
                decoration: BoxDecoration(
                  color: AppColors.white.withAlpha(20),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '72%',
                  style: AppTextStyles.h2Headline.copyWith(
                    color: AppColors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: 0.72,
              minHeight: 8.h,
              backgroundColor: AppColors.white.withAlpha(20),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.white),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${context.locale!.target}: ₴250000',
                style: AppTextStyles.targetsLabel.copyWith(
                  color: AppColors.white.withAlpha(80),
                ),
              ),
              Text(
                '${context.locale!.itsLeft} ₴70000',
                style: AppTextStyles.targetsLabel.copyWith(
                  color: AppColors.white.withAlpha(80),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridCards(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12.w,
      crossAxisSpacing: 12.w,
      childAspectRatio: 0.88,
      children: [
        _buildBaseCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.locale!.savingsDistribution,
                style: AppTextStyles.hintRegister.copyWith(
                  color: AppColors.secondaryTextColor,
                  height: 1.2,
                ),
              ),
              const Spacer(),
              Center(
                child: SizedBox(
                  width: 85.r,
                  height: 85.r,
                  child: CustomPaint(
                    painter: _DonutChartPainter(progress: 0.72),
                    child: Center(
                      child: Text(
                        '72%',
                        style: AppTextStyles.h2Headline.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        _buildBaseCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16.r,
                    color: AppColors.black,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    context.locale!.dateForecast,
                    style: AppTextStyles.hintRegister.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                'серп. 2027 р.',
                style: AppTextStyles.h1Headline.copyWith(
                  color: AppColors.black,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Через 15 міс.',
                style: AppTextStyles.hintRegister.copyWith(
                  color: AppColors.secondaryTextColor,
                ),
              ),
            ],
          ),
        ),
        _buildBaseCard(
          color: const Color(0xFFF7F4FF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Assets.icons.walletOutlined.image(
                    color: AppColors.purple,
                    width: 16.w,
                    height: 16.h,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    context.locale!.monthlyContribution,
                    style: AppTextStyles.targetsLabel.copyWith(
                      color: AppColors.purple,
                      height: 1.1.h,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                '₴25000',
                style: AppTextStyles.amountMain.copyWith(
                  color: AppColors.purple,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                context.locale!.currentPlan,
                style: AppTextStyles.hintRegister.copyWith(
                  color: AppColors.purple.withAlpha(80),
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
        _buildBaseCard(
          color: const Color(0xFFFFF9F2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.trending_up,
                    size: 16.r,
                    color: const Color(0xFFD97706),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    context.locale!.recommended,
                    style: AppTextStyles.targetsLabel.copyWith(
                      color: const Color(0xFFD97706),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                '₴25000',
                style: AppTextStyles.amountMain.copyWith(
                  color: const Color(0xFF78350F),
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'На місяць',
                style: AppTextStyles.hintRegister.copyWith(
                  color: const Color(0xFFB45309),
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrendCard(BuildContext context) {
    return _buildBaseCard(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Тренд заощаджень',
            style: AppTextStyles.h2Headline.copyWith(color: AppColors.black),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            height: 140.h,
            width: double.infinity,
            child: CustomPaint(
              painter: _LineChartPainter(
                dataPoints: [0.15, 0.25, 0.32, 0.48, 0.8],
                months: ['Січ', 'Лют', 'Бер', 'Кві', 'Тра'],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBaseCard({
    required Widget child,
    Color color = AppColors.white,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      padding: padding ?? EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          if (color == AppColors.white)
            BoxShadow(
              color: AppColors.black.withAlpha(3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: child,
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final double progress;

  _DonutChartPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 12.0;

    final bgPaint =
        Paint()
          ..color = const Color(0xFF4285F4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

    final progressPaint =
        Paint()
          ..color = AppColors.primaryColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.square;

    canvas.drawCircle(center, radius - strokeWidth / 2, bgPaint);

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LineChartPainter extends CustomPainter {
  final List<double> dataPoints;
  final List<String> months;

  _LineChartPainter({required this.dataPoints, required this.months});

  @override
  void paint(Canvas canvas, Size size) {
    final paintLine =
        Paint()
          ..color = const Color(0xFF52B472)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.5
          ..strokeCap = StrokeCap.round;

    final paintDot =
        Paint()
          ..color = const Color(0xFF52B472)
          ..style = PaintingStyle.fill;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final double widthBetweenPoints = size.width / (dataPoints.length - 1);
    final List<Offset> points = [];

    for (int i = 0; i < dataPoints.length; i++) {
      double x = i * widthBetweenPoints;
      double y = size.height - (dataPoints[i] * (size.height - 20.h)) - 10.h;
      points.add(Offset(x, y));
    }

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlPoint1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
      final controlPoint2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);
      path.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        p1.dx,
        p1.dy,
      );
    }
    canvas.drawPath(path, paintLine);

    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 5.r, paintDot);

      textPainter.text = TextSpan(
        text: months[i],
        style: TextStyle(
          color: AppColors.secondaryTextColor,
          fontSize: 11.sp,
          fontFamily: 'SF Pro',
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(points[i].dx - (textPainter.width / 2), size.height + 8.h),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

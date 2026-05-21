import '../../features/auth/login/screens/login_screen.dart';
import '../../features/auth/login/screens/registration_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/home/tabs/transactions/add_transaction/add_transaction_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/onboarding/screens/onboarding_screen.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.onboarding.path,
  routes: [
    GoRoute(
      path: AppRoutes.home.path,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.login.path,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding.path,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.registration.path,
      builder: (context, state) => const RegistrationScreen(),
    ),
    GoRoute(
      path: AppRoutes.addTransaction.path,
      builder: (context, state) => const AddTransactionScreen(),
    ),
  ],
);

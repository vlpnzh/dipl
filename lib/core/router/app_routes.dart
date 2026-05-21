enum AppRoutes {
  home(path: '/'),
  login(path: '/login'),
  onboarding(path: '/onboarding'),
  registration(path: '/registration'),
  addTransaction(path: '/add-transaction');

  const AppRoutes({required this.path});

  final String path;
}

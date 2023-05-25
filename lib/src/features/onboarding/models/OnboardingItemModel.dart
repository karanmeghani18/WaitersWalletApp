class OnboardingItemModel {
  final String iconLocation;
  final String title;
  final String subtitle;
  final bool isAppLogo;

  OnboardingItemModel({
    required this.iconLocation,
    required this.title,
    required this.subtitle,
    this.isAppLogo = false,
  });
}

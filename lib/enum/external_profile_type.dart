enum ExternalProfileType {
  linkedIn('https://www.linkedin.com/in/kinnathanchan/',
      'assets/icons/LinkedIn_icon.png'),
  gitHub('https://github.com/NathanCK/MyFlutterPortfolio',
      'assets/icons/GitHub_icon.png');

  const ExternalProfileType(this.url, this.iconPath);

  final String url;
  final String iconPath;
}

class AppPath {
  static const String home = '/home';
  static const String experience = '/experience';
  static const String experienceDetail = '$experience/:experienceId';
  static const String about = '/about';

  static String getExperienceDetailUri(int id) {
    return '$experience/$id';
  }
}

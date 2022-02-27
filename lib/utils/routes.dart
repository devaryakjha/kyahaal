import 'package:get/route_manager.dart';
import 'package:kyahaal/pages/home/index.dart';
import 'package:kyahaal/pages/login/index.dart';
import 'package:kyahaal/pages/splash.dart';
import 'package:kyahaal/utils/index.dart';

class Routes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgotPassword';
  static const String resetPassword = '/resetPassword';
  static const String profile = '/profile';
  static const String editProfile = '/editProfile';
  static const String changePassword = '/changePassword';
  static List<GetPage> pages = [
    GetPage(name: splash, page: () => const Splash()),
    GetPage(name: home, page: () => const Home(), binding: HomeBindings()),
    GetPage(name: login, page: () => const Login()),
  ];
}

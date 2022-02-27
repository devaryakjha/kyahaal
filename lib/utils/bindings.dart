import 'package:get/get.dart';
import 'package:kyahaal/controllers/app.dart';
import 'package:kyahaal/controllers/index.dart';
import 'package:kyahaal/controllers/user.dart';

class InitialBinding implements Bindings {
  static InitialBinding get instance => InitialBinding();
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(NetworkController());
  }
}

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
    Get.put(AppController());
  }
}

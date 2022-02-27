import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Rxn<User> firebaseUser = Rxn();

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(auth.userChanges());
  }
}

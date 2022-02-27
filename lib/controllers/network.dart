import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  static NetworkController get to => Get.find();
  late StreamSubscription<ConnectivityResult> _subscription;
  final Rx<ConnectivityResult> _currenState = ConnectivityResult.none.obs;

  bool get isConnected => [
        ConnectivityResult.mobile,
        ConnectivityResult.wifi,
        ConnectivityResult.ethernet
      ].contains(_currenState.value);

  void setCurrentState(ConnectivityResult state) => _currenState.value = state;

  void _handleConnectionChange(ConnectivityResult result) {
    if (isConnected) {
      FlushbarHelper.createSuccess(message: 'Connected')
          .show(Get.overlayContext!);
    } else {
      FlushbarHelper.createError(message: 'No Connection')
          .show(Get.overlayContext!);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _subscription =
        Connectivity().onConnectivityChanged.listen(setCurrentState);
    ever(_currenState, _handleConnectionChange);
  }

  @override
  void onClose() {
    super.onClose();
    _subscription.cancel();
  }
}

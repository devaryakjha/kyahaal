import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyahaal/utils/index.dart';

enum LoginState {
  initial,
  sendingOTP,
  resendingOTP,
  sentOTP,
  verifyingOTP,
  verifiedOTP,
}

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final GlobalKey<FormState> loginformKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final RxInt _timeToResendOTP = RxInt(0);
  final RxnString _verificationId = RxnString();
  final RxnInt _resedningToken = RxnInt();
  final RxBool _isLoading = false.obs;
  final RxBool _isLoggedIn = false.obs;
  final Rxn<User> _user = Rxn();
  final Rx<LoginState> _loginState = LoginState.initial.obs;

  bool get isLoading => _isLoading();
  bool get isLoggedIn => _isLoggedIn();
  User? get user => _user();
  LoginState get loginState => _loginState();
  String? get verificationId => _verificationId();
  int? get resedningToken => _resedningToken();
  int get timeToResendOTP => _timeToResendOTP();
  String get timeToResendOTPText => _secondsToTimeRemaining(timeToResendOTP);
  String get loginBtnText {
    switch (loginState) {
      case LoginState.initial:
        return 'Send OTP';
      case LoginState.sendingOTP:
        return 'Sending OTP . . .';
      case LoginState.sentOTP:
        return 'Verify OTP';
      case LoginState.verifyingOTP:
        return 'Verifying OTP...';
      case LoginState.verifiedOTP:
        return 'Success';
      default:
        return 'Send OTP';
    }
  }

  set setLoading(bool value) => _isLoading.value = value;
  set setLoggedIn(bool value) => _isLoggedIn.value = value;
  set setUser(User? value) => _user.value = value;
  set setLoginState(LoginState value) => _loginState.value = value;
  set setVerificationId(String? value) => _verificationId.value = value;
  set setResedningToken(int? value) => _resedningToken.value = value;
  set setTimeToResendOTP(int value) => _timeToResendOTP.value = value;

  void startAuthCheck() {
    ever(_user, (User? user) => _authCheck(user: user));
    ever(_isLoggedIn, _handleLoginStatusChange);
    _authCheck();
  }

  void _authCheck({User? user}) {
    user ??= this.user;
    setLoading = true;
    if (user != null) {
      setLoggedIn = true;
    } else {
      setLoggedIn = false;
    }
    setLoading = false;
  }

  void _handleLoginStatusChange(bool isLoggedIn) {
    if (isLoggedIn) {
      flush();
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

  void handleLoginClick() {
    final bool isFormValid = loginformKey.currentState?.validate() ?? false;
    if (isFormValid) {
      switch (loginState) {
        case LoginState.initial:
          _verifyPhoneNumber();
          break;
        case LoginState.sentOTP:
          _verifyOTP();
          break;
        default:
      }
    }
  }

  // Call this method to send OTP to user
  Future<void> _verifyPhoneNumber({bool resending = false}) async {
    final previousState = loginState;
    setLoginState = LoginState.sendingOTP;
    await auth.verifyPhoneNumber(
      phoneNumber: '+91${phoneController.text}',
      timeout: Duration(seconds: resending ? 60 : 30),
      verificationCompleted: (credential) {},
      verificationFailed: (FirebaseAuthException error) {
        setLoginState = previousState;
      },
      codeSent: (a, b) {
        setLoginState = LoginState.sentOTP;
        setVerificationId = a;
        setResedningToken = b;
        _startResendOTPTimer(resending ? 60 : 30);
      },
      codeAutoRetrievalTimeout: (a) {},
      forceResendingToken: resending ? resedningToken : null,
    );
  }

  Future<void> _verifyOTP({PhoneAuthCredential? credential}) async {
    final previousState = loginState;
    setLoginState = LoginState.verifyingOTP;
    credential ??= PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: otpController.text,
    );
    final creds = await auth
        .signInWithCredential(credential)
        .onError((error, stackTrace) {
      setLoginState = previousState;
      throw error ?? '';
    });

    if (creds.user != null && nameController.text.isNotEmpty) {
      creds.user!.updateDisplayName(nameController.text);
    }
  }

  void _startResendOTPTimer([int time = 30]) {
    setTimeToResendOTP = time;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setTimeToResendOTP = timeToResendOTP - 1;
      if (timeToResendOTP == 0 || isLoggedIn) {
        timer.cancel();
      }
    });
  }

  void resendOTP() {
    setLoginState = LoginState.resendingOTP;
    _verifyPhoneNumber(resending: true);
  }

  String _secondsToTimeRemaining(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void logout() => auth.signOut();

  void flush() {
    setLoading = false;
    setLoginState = LoginState.initial;
    setResedningToken = null;
    setVerificationId = null;
    setTimeToResendOTP = 0;
    phoneController.clear();
    otpController.clear();
    nameController.clear();
  }

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(auth.authStateChanges());
  }
}

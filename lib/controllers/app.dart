import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyahaal/utils/constants.dart';

class AppController extends GetxController {
  final RxInt _navCurrIndex = RxInt(0);
  final PageController pageController = PageController();

  int get navCurrIndex => _navCurrIndex();

  void changeCurrIndex(int index) => _navCurrIndex.value = index;

  @override
  void onInit() {
    super.onInit();
    ever(_navCurrIndex, (int index) {
      pageController.animateToPage(
        index,
        duration: kAnimationDuration,
        curve: Curves.easeIn,
      );
    });
  }
}

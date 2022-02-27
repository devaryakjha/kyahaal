import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyahaal/utils/index.dart';

class KyaHaal extends StatelessWidget {
  const KyaHaal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KyaHaal',
        getPages: Routes.pages,
        initialRoute: Routes.splash,
        theme: theme,
        initialBinding: InitialBinding.instance,
      ),
    );
  }
}

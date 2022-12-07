import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';
import '../utils/local_assets_image.dart';

class SpalashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: SplashController(),
        builder: (_) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(SPLASH_IMAGE),
                  fit: BoxFit.cover
                )),
          );
        },
      ),
    );
  }
}

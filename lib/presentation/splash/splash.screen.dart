import 'package:carousel_slider/carousel_slider.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:growit/infrastructure/services/avatar_service.dart';
import 'package:growit/infrastructure/theme/colors_data.dart';

import 'controllers/splash.controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: [kPrimaryColor, kSecondaryColor],
      //   ),
      // ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Entry.all(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 60,
                    child: SvgPicture.asset('assets/logo.svg'),
                  ),
                ),
                Entry.all(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'Start your jurney',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: kTextColor,
                          fontSize: 30,
                        ),
                  ),
                ),
                Entry.all(
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    'with us',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 1 / 1,
                    viewportFraction: 0.25,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlayInterval: const Duration(milliseconds: 100),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pageSnapping: false,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    enlargeFactor: 0.4,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: [
                    '7294793.jpg',
                    '9334389.jpg',
                    '9334407.jpg',
                    '9439767.jpg',
                    '9440461.jpg'
                  ].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return AdvancedAvatar(
                          size: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          animated: true,
                          image: AssetImage('assets/images/$i'),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            Obx(
              () => !controller.isLoading.value
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 3,
                        width: 100,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: kWhiteColor.withOpacity(0.2),
                        ),
                        child: const LinearProgressIndicator(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

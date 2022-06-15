import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutterapp/position.dart';
import 'package:http/http.dart';
import 'cards_design.dart';
import 'student.dart';
import 'send.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';



//import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
String URL="positionvoiture.herokuapp.com";
class SplashScreen2 extends StatelessWidget {
  final String id;

  const SplashScreen2(this.id,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/45410-position.json'),
      /*splash: Column(
        children: [
          Image.asset('assets/map.png'),
          const Text('Gestion Tracer',style: TextStyle(fontSize:40))
        ],
      ),*/

      // Column(
      //   children: [
      ///TODO Add your image under assets folder
      //     Image.asset('assets/logo_icon.png'),
      //     const Text('Cake app', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),)
      //   ],
      // ),
      backgroundColor: Colors.white,
      nextScreen: MyMap(id),
      splashIconSize: 250,
      duration: 100,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: const Duration(seconds: 1),
    );
  }
}
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash:




      ///TODO Add your image under assets folder
           Lottie.asset('assets/105682-geo-position-location.json'),
           //const Text('Cake app', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),)


      backgroundColor: Colors.white,
      nextScreen: const MakeDashboardItems(),
      splashIconSize: 250,
      duration: 500,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: const Duration(seconds: 1),
    );
  }
}
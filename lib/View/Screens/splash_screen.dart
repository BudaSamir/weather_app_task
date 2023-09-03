import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:loudweather/ViewModel/cubits/home_screen_cubit/home_screen_cubit.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await loadTime();
    });
    super.initState();
  }

  loadTime() async {
    Timer(
      const Duration(seconds: 6),
      (() => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const HomeScreen())))),
    );
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    final homeCubit = HomeScreenCubit.get(context);
    homeCubit.getPotion();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff060720),
        body: SizedBox(
          height: myHeight,
          width: myWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Lottie.asset('assets/img/loading.json'),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(colors: [
                  Color(0xff955cd1),
                  Color(0xff3fa2fa),
                ]).createShader(bounds),
                child: Text('Loud Weather',
                    style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 50,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

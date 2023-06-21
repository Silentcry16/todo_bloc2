import 'package:flutter/material.dart';
import 'package:todo_bloc2/gen/assets.gen.dart';
import 'package:todo_bloc2/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then(
        (value) => Navigator.pushReplacementNamed(context, HomeScreen.id));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width / 2.2,
                    child: Image.asset(
                      Assets.images.splash.path,
                    ),
                  ),
                  SizedBox(
                    width: size.width / 2.2,
                    child: Image.asset(
                      Assets.images.logo.path,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  const Text(
                    'Stay organized and productive',
                    style: TextStyle(
                        fontFamily: 'balker',
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 2),
            SizedBox(
              width: size.width / 3,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  Assets.images.autherLogo.path,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            )
            // const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}

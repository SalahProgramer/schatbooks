import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../model/apis/api.dart';
import 'Home.dart';
import 'login.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  bool loading = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      setState(() {
        loading = true;
      });
      await Future.delayed(const Duration(seconds: 4))
          .then((value){
        if(API.auth.currentUser!=null){
          Get.off(()=> const Home());


        }else{
          Get.off(()=>const login());


        }


      });
    });

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/Curves.jpg"), fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
            ),
            const SizedBox(
              width: 110,

              // height: 200,
              child: Image(
                image: AssetImage("images/result.png"),
              ),
            ),
            const Spacer(),
            loading == true
                ? Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: const SpinKitFadingFour(
                  color: Colors.black,
                ))
                : const Text("")
          ],
        ),
      ),
    );
  }
}
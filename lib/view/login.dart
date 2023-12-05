import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/apis/api.dart';
import 'Home.dart';


class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool animate = false;
  bool circle = false;

  GoogleClick() async {
    signInWithGoogle().then((value) async {
      if(value!=null){
        if((await API.userExists())){

          print("name:      ${value.user?.displayName}");

          Get.back();
          setState(() {
            circle = true;
          });
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              circle = false;
            });

            Get.to(()=>const Home());
          });
        }
        else{
print("llllllllllllllllllllllllllllllllllll");
          await API.createUser().then((value){

            Get.back();
            setState(() {
              circle = true;
            });
            Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                circle = false;
              });
              Get.to(()=>const Home());
            });
          });
        }

      }
      else{
        GoogleSignIn().signOut();
        Get.back();
        Fluttertoast.showToast(
            msg: "Not select gmail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.black,
            fontSize: 16.0);
      }

    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    try{
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await API.auth.signInWithCredential(credential);
    }catch(e){
      if (e.toString().isEmpty) {
        Fluttertoast.showToast(
            msg: "user-not-found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    }
    return null;
  }

  @override
  void dispose() {

    setState(() {
      circle = false;
    });

    super.dispose();
  }

  @override
  void initState() {



    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Welcome to Schatbook"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/Curves.jpg"), fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),

                width: animate ? 170 : 0,
                // height: 200,
                child: Image(
                  image: const AssetImage("images/result.png"),
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  height: MediaQuery.of(context).size.height * 0.06,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            spreadRadius: 3,
                            blurStyle: BlurStyle.outer,
                            blurRadius: 20)
                      ]),
                  child: Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black26,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          shadowColor: Colors.transparent,
                          alignment: Alignment.center,
                          foregroundColor: Colors.black),
                      onPressed: () async {

                        Get.generalDialog(
                          barrierColor: Colors.transparent,
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.black,
                                  backgroundColor: Colors.transparent,
                                  strokeWidth: 2),
                            );
                          },
                        );
                        await Future.delayed(const Duration(microseconds: 100));
                        await GoogleClick();

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          circle == false
                              ? Image.asset("images/google.png",
                              height:
                              MediaQuery.of(context).size.height * 0.03)
                              : const CircularProgressIndicator(
                              color: Colors.black, strokeWidth: 2),
                          const SizedBox(
                            width: 10,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                                style:
                                TextStyle(fontSize: 15, color: Colors.black),
                                children: [
                                  TextSpan(text: "Login with"),

                                  TextSpan(
                                      text: " Google",
                                      style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                                ]),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

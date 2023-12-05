import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:schatbooks/model/apis/api.dart';
import 'package:schatbooks/view/login.dart';
import 'package:schatbooks/view/profile.dart';

import 'HomeShow.dart';
import 'friends.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
var indexProvider=StateProvider<int>((ref)=>1);
class Home extends ConsumerWidget {
   const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
var mq = MediaQuery.of(context).size;
return WillPopScope(
  onWillPop: () async {
    return await showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          actionScrollController: ScrollController(
              keepScrollOffset: true, initialScrollOffset: 10),
          title: const Text("Log out",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          content: const Text("Are you sure to log out",
              style: TextStyle(
                  fontFamily: 'CrimsonText',
                  fontSize: 15,
                  color: Colors.black87)),
          actions: [
            TextButton(
                onPressed: () async {
                  // await API.updateActiveStatus(false);

                  await API.auth.signOut().then((value) async {
                    await GoogleSignIn().signOut().then((value) {
                      Get.offAll(() => const login());
                      API.auth = FirebaseAuth.instance;
                    });
                  });
                },
                child: const Text("Yes")),
            TextButton(
                onPressed: () async {
                  Get.back();
                },
                child: const Text("No"))
          ],
        );
      },
    );
  },
  child: Container(

    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/Curves.jpg"), fit: BoxFit.fill)),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      bottomNavigationBar:   Container(

        margin:
        const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 5),
        decoration:
        const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 25,
                blurStyle: BlurStyle.outer,
              )
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            currentIndex: ref.watch(indexProvider),
            backgroundColor: Colors.white70,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.black,

            showUnselectedLabels: false,
            onTap: (value) {
             ref.read(indexProvider.state).state=value;

            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: "Profile"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_add_alt_outlined), label: "Friends"),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.menu), label: "Menu"),
            ],
          ),
        ),
      )
      ,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title:ref.watch(indexProvider)!=0? Text(
          API.user.displayName.toString(),
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              height: 1,
              fontSize: 25,
              color: Colors.black,
              fontFamily: "Agbalumo"),
        ):Text("My Profile", style: TextStyle(
            decoration: TextDecoration.none,
            shadows: [
              Shadow(blurRadius: 10, color: Colors.lightBlue)
            ],
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: "Agbalumo")),
        leading: Badge(
            backgroundColor: Colors.green,
            isLabelVisible: true,
            alignment: Alignment.center,
            offset: const Offset(4, 3),
            label: const Text("0"),
            largeSize: 15,
            child: IconButton(
                onPressed: () {},
                icon: const Image(
                  image: AssetImage("images/img.png"),
                ))),
        actions: [
          IconButton(
            onPressed: () {
              showCupertinoDialog<String>(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      actionScrollController: ScrollController(
                          keepScrollOffset: true, initialScrollOffset: 10),
                      title: const Text("Log out",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22)),
                      content: const Text("Are you sure to log out",
                          style: TextStyle(
                              fontFamily: 'CrimsonText',
                              fontSize: 15,
                              color: Colors.black87)),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              // await API.updateActiveStatus(false);

                              await API.auth.signOut().then((value) async {
                                await GoogleSignIn().signOut().then((value) {
                                  Get.offAll(() => const login());
                                  API.auth = FirebaseAuth.instance;
                                });
                              });
                            },
                            child: const Text("Yes")),
                        TextButton(
                            onPressed: () async {
                              Get.back();
                            },
                            child: const Text("No"))
                      ],
                    );
                  });
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: IndexedStack(
        index: ref.watch(indexProvider),
        children: const[
          Profile(),
          HomeShow(),
          Friends()
        ],
      ),
    ),
  ),
);  }

   StyleItems() {
     return const TextStyle(
         fontWeight: FontWeight.w500,
         height: 1,
         fontSize: 20,
         color: Colors.black,
         fontFamily: "VarelaRound");
   }
}





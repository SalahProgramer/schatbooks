
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schatbooks/Services/notification_service.dart';
import 'package:shimmer/shimmer.dart';

import '../model/apis/api.dart';
import '../model/apis/chat_user.dart';

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  List<ChatUser> list = [];

  final dataProvider = StreamProvider.autoDispose((ref) => API.getAllusers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Friends",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          shadows: [
                            Shadow(blurRadius: 10, color: Colors.lightBlue)
                          ],
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: "Agbalumo")),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      alignment: Alignment.center,
                    ),
                    child: const Icon(Icons.person_search,
                        color: Colors.black, size: 30),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer(
                builder: (context, ref, child) {
                  final data = ref.watch(dataProvider);

                  return Expanded(
                      child: Container(
                    child: data.when(
                      data: (data) {
                        final d = data.docs;
                        list = d
                                .map((e) => ChatUser.fromJson(e.data()))
                                .toList() ??
                            [];

                        if (list.isNotEmpty) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              print(list.length.toString() +
                                  "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                              return card(list[index], index);
                            },
                          );
                        } else {
                          return ListView.builder(
                            //             // reverse: true,
                            //             // padding: EdgeInsets.only(bottom: 20),
                            //             // controller: scrollController,
                            //             // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                            //
                            itemCount: 5,

                            itemBuilder: (context, index) {
                              return cardShimmer();
                            },
                          );
                        }
                      },
                      loading: () {
                        print(list.length);
                        return ListView.builder(
                          //             // reverse: true,
                          //             // padding: EdgeInsets.only(bottom: 20),
                          //             // controller: scrollController,
                          //             // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                          //
                          itemCount: 5,

                          itemBuilder: (context, index) {
                            return cardShimmer();
                          },
                        );
                      },
                      error: (error, stackTrace) {
                        return const Center(
                          child: Text("error"),
                        );
                      },
                    ),
                  ));
                },
              ),

//              Expanded(
//                child: Container(
//                  child: ListView.builder(
//                    itemCount: 3,
//
//                    itemBuilder: (context, index) {
// return  card();
//
//
//                  },),
//                ),
//              )
            ],
          ),
        ),
      ),
    );
  }

  Widget card(ChatUser user, int values) {
    return Expanded(
      child: SizedBox(
          width: double.maxFinite,
          child: Card(
            shape: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: CachedNetworkImage(
                      // width: MediaQuery.of(context).size.width < 600
                      //     ? MediaQuery.of(context).size.height * 0.055
                      //     : MediaQuery.of(context).size.height * 0.085,
                      // height: MediaQuery.of(context).size.width < 600
                      //     ? MediaQuery.of(context).size.height * 0.055
                      //     : MediaQuery.of(context).size.height * 0.085,
                      imageUrl: user.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[500]!,
                        highlightColor: Colors.grey[100]!,
                        child: Expanded(
                          child: Container(
                            width: double.maxFinite,
                            height: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: "Agbalumo")),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(user.email.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: "CrimsonText")),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black,
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            blurStyle: BlurStyle.outer)
                                      ],
                                      // border: Border.all(color: Colors.black,width: 2),
                                      gradient: LinearGradient(colors: [
                                        Colors.blue,
                                        Colors.black,

                                        // Colors.white38,
                                      ], transform: GradientRotation(90)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.person_add_alt_outlined,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Add Friend",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Agbalumo"),
                                      )
                                    ],
                                  )),
                            ),
                            InkWell(
                              onTap: () async {
                                //show notification
                                // await NotificationService.showNotification(title: user.name, body: user.email);

                                //show notification with summary
                                //  await NotificationService.showNotification(title: user.name, body: user.email,summry: "Small summary",
                                //  notificationLayout: NotificationLayout.Inbox);

                                // Notification progress Bar
                                // await NotificationService.showNotification(title: user.name, body: user.email,summry: "Small summary",
                                //     notificationLayout: NotificationLayout.ProgressBar);

                                //Notification Message Notification
                                // await NotificationService.showNotification(title: user.name, body: user.email,summry: "Small summary",
                                //     notificationLayout: NotificationLayout.Messaging);

                                //Notification big image
                                // await NotificationService.showNotification(title: user.name, body: user.email,summry: "Small summary",
                                //     notificationLayout: NotificationLayout.BigPicture,bigPicture: user.image);

                                //notification button
                                // await NotificationService.showNotification(
                                //
                                //     title: user.name,
                                //     body: user.email,
                                //     summry: "Small summary",
                                //     actionButtons: [
                                //       NotificationActionButton(
                                //           key: "Accept",
                                //           label: "Add friend",
                                //           color: Colors.blue,
                                //           autoDismissible: true),
                                //       NotificationActionButton(
                                //           key: "DISMISS",
                                //           label: "Dismiss",
                                //           color: Colors.black54,
                                //           autoDismissible: true),
                                //     ]);

                                // //show buttons with summary
                                // await NotificationService.showNotification(
                                //     summry: "Small summary",
                                //         notificationLayout: NotificationLayout.Messaging,
                                //     title: user.name,
                                //     body: user.email,
                                //     actionButtons: [
                                //       NotificationActionButton(
                                //           key: "Accept",
                                //           label: "Add friend",
                                //           color: Colors.blue,
                                //           autoDismissible: true),
                                //       NotificationActionButton(
                                //           key: "DISMISS",
                                //           label: "Dismiss",
                                //           color: Colors.black54,
                                //           autoDismissible: true),
                                //     ]);

                                //show notification Schadule waiting 5 seconds
                                await NotificationService.showNotification(
                                    summry: "Small summary",
                                        notificationLayout: NotificationLayout.Default,
                                    title: user.name,
                                    body: user.email,
actionType: ActionType.KeepOnTop,
                                    imageProfile: user.image,
                                    actionButtons: [
                                      NotificationActionButton(
                                          key: "Accept",
                                          label: "Add friend",
                                          color: Colors.blue,
                                          autoDismissible: true),
                                      NotificationActionButton(
                                          key: "DISMISS",
                                          label: "Dismiss",
                                          color: Colors.black54,
                                          autoDismissible: true),
                                    ]);


//                               print("jj");
//                               setState(() {
//                                 print(values);
//                                 list.removeAt(values);
//
// print(list.length);
//
//                               });
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black,
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            blurStyle: BlurStyle.outer)
                                      ],
                                      // border: Border.all(color: Colors.black,width: 2),
                                      gradient: LinearGradient(colors: [
                                        Colors.white,
                                        Colors.white54,

                                        // Colors.white38,
                                      ], transform: GradientRotation(90)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.person_remove_outlined,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "  Remove  ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Agbalumo"),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
  Widget cardShimmer(){
    return Container(
// height: 200,
      child: Card(
        shape: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // CircleAvatar(
                      //   backgroundImage: AssetImage("images/Curves.png"),
                      //   radius: 20,
                      // ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width < 600
                                ? MediaQuery.of(context).size.height * 0.055
                                : MediaQuery.of(context).size.height * 0.085,
                            height: MediaQuery.of(context).size.width < 600
                                ? MediaQuery.of(context).size.height * 0.055
                                : MediaQuery.of(context).size.height * 0.085,
                            imageUrl: "",
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[500]!,
                              highlightColor: Colors.grey[100]!,
                              child: Expanded(
                                child: Container(
                                  width: double.maxFinite,
                                  height: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                            // Icon(Icons.error),
                            Shimmer.fromColors(
                              baseColor: Colors.grey[500]!,
                              highlightColor: Colors.grey[100]!,
                              child: Expanded(
                                child: Container(
                                  width: double.maxFinite,
                                  height: 10,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ),

                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(this.widget.post.name.toString(),
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: 20,
                          //         color: Colors.black,
                          //         fontFamily: "Agbalumo")),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[500]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[500]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.more_horiz)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.cancel)),
                    ],
                  ),
                ],
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[500]!,
                highlightColor: Colors.grey[100]!,
                period: const Duration(seconds: 2),
                child: Container(
                  width: double.maxFinite,
                  height: 15,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                width: double.maxFinite,
                padding: const EdgeInsets.all(0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[500]!,
                  highlightColor: Colors.grey[100]!,
                  child: Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "like",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.mode_comment_outlined,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "comment",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "share",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );

  }

}

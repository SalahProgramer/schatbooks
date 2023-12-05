import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';

import '../model/apis/api.dart';
import '../model/apis/post.dart';

class card extends ConsumerWidget {
  final Post post;
   card({super.key, required this.post});


  final  LikeProvider=StateProvider<bool>((ref) => false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final like=ref.watch(LikeProvider);
    return post.images.isEmpty? Container(
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
                          imageUrl: post.imageUrl,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.5,

                            child: Text(post.name.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: "Agbalumo")),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.5,

                            child: Text(post.email.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: "CrimsonText")),
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
                      post.email==API.auth.currentUser?.email? IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  actionScrollController: ScrollController(
                                      keepScrollOffset: true,
                                      initialScrollOffset: 10),
                                  title: const Text("Delete Post",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22)),
                                  content: const Text("Are you sure to Delete post",
                                      style: TextStyle(
                                          fontFamily: 'CrimsonText',
                                          fontSize: 15,
                                          color: Colors.black87)),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          Get.back();

                                          await API.deletePost(post);

                                          Fluttertoast.showToast(
                                              msg:
                                              "Was Delete post to ${API.user.displayName}",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.blue,
                                              textColor: Colors.black,
                                              fontSize: 16.0);
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
                          icon: const Icon(Icons.cancel)):SizedBox(),
                    ],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                width: double.maxFinite,
                padding: const EdgeInsets.all(0),
                child: Text(post.text.toString().trim(),
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        shadows: [
                          Shadow(blurRadius: 10, color: Colors.greenAccent)
                        ],
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: "CrimsonText")),
              ),

              post.images.isEmpty==true?SizedBox():              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    imageUrl: post.images[0],
                    // widget.post.images[0].toString(),

                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[500]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.maxFinite,
                          height: 10,
                          color: Colors.white,
                        ),
                      );
                      // CircularProgressIndicator(
                      //    color: Colors.black,
                      // strokeWidth: 0,
                      // value: 30,
                      //
                      //  );
                    },
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(height: 10,),

              ref.read(LikeProvider.notifier).state==true?SizedBox(): Row(
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width*0.5,

                    child: Text(post.name.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: "CrimsonText")),
                  )

                ],
              ),

              const Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        backgroundColor: Colors.transparent,
                        elevation: 0,


                      );

                      ref.read(LikeProvider.notifier).state=!ref.read(LikeProvider.notifier).state;



                    },
                    onFocusChange: (value) {

                      ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        backgroundColor: Colors.transparent,
                        elevation: 0,


                      );
                    },
                    icon:  ref.read(LikeProvider.notifier).state==true? Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                    ):  Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    label:  ref.read(LikeProvider.notifier).state==true? Text(
                      "like",
                      style: TextStyle(color: Colors.black),
                    ):  Text(
                      "liked",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                      backgroundColor: Colors.transparent,
                      elevation: 0,

                    ),
                    onLongPress: () {


                      ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        backgroundColor: Colors.transparent,
                        elevation: 0,


                      );
                    },
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
    ):Container(

          height: MediaQuery.of(context).size.height * 0.65,

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
                          imageUrl: post.imageUrl,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.5,

                            child: Text(post.name.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: "Agbalumo")),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.5,

                            child: Text(post.email.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: "CrimsonText")),
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
                      post.email==API.auth.currentUser?.email? IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  actionScrollController: ScrollController(
                                      keepScrollOffset: true,
                                      initialScrollOffset: 10),
                                  title: const Text("Delete Post",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22)),
                                  content: const Text("Are you sure to Delete post",
                                      style: TextStyle(
                                          fontFamily: 'CrimsonText',
                                          fontSize: 15,
                                          color: Colors.black87)),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          Get.back();

                                          await API.deletePost(post);

                                          Fluttertoast.showToast(
                                              msg:
                                              "Was Delete post to ${API.user.displayName}",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.blue,
                                              textColor: Colors.black,
                                              fontSize: 16.0);
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
                          icon: const Icon(Icons.cancel)):SizedBox(),
                    ],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                width: double.maxFinite,
                padding: const EdgeInsets.all(0),
                child: Text(post.text.toString().trim(),
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        shadows: [
                          Shadow(blurRadius: 10, color: Colors.greenAccent)
                        ],
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: "CrimsonText")),
              ),

              post.images.isEmpty==true?SizedBox():              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    imageUrl: post.images[0],
                    // widget.post.images[0].toString(),

                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[500]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.maxFinite,
                          height: 10,
                          color: Colors.white,
                        ),
                      );
                      // CircularProgressIndicator(
                      //    color: Colors.black,
                      // strokeWidth: 0,
                      // value: 30,
                      //
                      //  );
                    },
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),

              SizedBox(height: 10,),
              ref.read(LikeProvider.notifier).state==true?SizedBox(): Row(
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width*0.5,

                    child: Text(post.name.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: "CrimsonText")),
                  )

                ],
              ),
              const Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        backgroundColor: Colors.transparent,
                        elevation: 0,


                      );

                      ref.read(LikeProvider.notifier).state=!ref.read(LikeProvider.notifier).state;



                    },
                    onFocusChange: (value) {

                      ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        backgroundColor: Colors.transparent,
                        elevation: 0,


                      );
                    },
                    icon:  ref.read(LikeProvider.notifier).state==true? Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                    ):  Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    label:  ref.read(LikeProvider.notifier).state==true? Text(
                      "like",
                      style: TextStyle(color: Colors.black),
                    ):  Text(
                      "liked",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                      backgroundColor: Colors.transparent,
                      elevation: 0,

                    ),
                    onLongPress: () {


                      ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        backgroundColor: Colors.transparent,
                        elevation: 0,


                      );
                    },
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

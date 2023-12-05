import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../model/apis/api.dart';
import '../model/apis/post.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final dataProvider = StreamProvider.autoDispose((ref) => API.getAllMyposts());
  List<Post> list = [];

  @override
  Widget build(BuildContext context) {
    list.add(Post(images: [""], imageUrl: "", name: "", CreateAt: "", text: "", id: "", email: ""));

    return         Consumer(
      builder: (context, ref, child) {
        final data = ref.watch(dataProvider);

        return Expanded(
            child: Container(
              child: data.when(
                data: (data) {
                  final d = data.docs;
                  list=[];
                  list.add(Post(images: [""], imageUrl: "", name: "", CreateAt: "", text: "", id: "", email: ""));

                  list.addAll(
                      d.map((e) => Post.fromJson(e.data())).toList());




                  if (list.length>=1) {
                    print(list.length.toString()+"ffffffffffffff");
                    return   ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        print(index);
                        return
                          index==0?Profile():

                         ( list[index].images.isEmpty
                            ? card(list[index])
                            :  CardWithPicture(
                            list[index],
                            list[index].images[0]));

                      },
                    );

                    // ListView.builder(
                    //   // reverse: true,
                    //   // padding: EdgeInsets.only(bottom: 20),
                    //   // controller: scrollController,
                    //   // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    //   itemCount: list.length,
                    //   itemBuilder: (context, index) {
                    //     return cardShimmer(post: list[index]);
                    //   },
                    // );
                  } else {
                    list=[];
                    list.add(Post(images: [""], imageUrl: "", name: "", CreateAt: "", text: "", id: "", email: ""));
                    return ListView.builder(

                      // reverse: true,
                      // padding: EdgeInsets.only(bottom: 20),
                      // controller: scrollController,
                      // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return index==0?Profile(): cardShimmer(list[index]);
                      },
                    );
                  }
                },
                loading: () {
                  list=[];
                  list.add(Post(images: [""], imageUrl: "", name: "", CreateAt: "", text: "", id: "", email: ""));
                  return ListView.builder(
                    //             // reverse: true,
                    //             // padding: EdgeInsets.only(bottom: 20),
                    //             // controller: scrollController,
                    //             // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    //
                    itemCount: list.length,

                    itemBuilder: (context, index) {
                      return  index==0?Profile():cardShimmer( list[index]);
                    },
                  );
                },
                error: (error, stackTrace) {
                  return   Center(
                    child: Text(error.toString()),
                  );
                },
              ),
            ))

        //   Expanded(
        //   child: StreamBuilder(
        //     stream: API.getAllposts(),
        //     builder: (context, snapshot) {
        //       switch (snapshot.connectionState) {
        //         case ConnectionState.waiting:
        //
        //
        //           return   ListView.builder(
        //             // reverse: true,
        //             // padding: EdgeInsets.only(bottom: 20),
        //             // controller: scrollController,
        //             // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        //
        //             itemCount: list.length,
        //
        //             itemBuilder: (context, index) {
        //
        //               return   cardShimmer(post: list[index]);
        //             },
        //           );
        //         case ConnectionState.none:
        //           return  ListView.builder(
        //             // reverse: true,
        //             // padding: EdgeInsets.only(bottom: 20),
        //             // controller: scrollController,
        //             // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        //             addAutomaticKeepAlives: true,
        //             addRepaintBoundaries: true,
        //             physics: BouncingScrollPhysics(),
        //
        //
        //             itemCount: list.length,
        //
        //             itemBuilder: (context, index) {
        //
        //               return   cardShimmer(post: list[index]);
        //             },
        //           );
        //         case ConnectionState.active:
        //
        //         case ConnectionState.done:
        //           final data = snapshot.data?.docs;
        //           list = data
        //               ?.map((e) => Post.fromJson(e.data()))
        //               .toList() ??
        //               [];
        //
        //
        //           if (list.isNotEmpty) {
        //             print(list.length);
        //             return
        //
        //
        //               ListView.builder(
        //
        //
        //
        //                 physics: BouncingScrollPhysics(),
        //                 itemCount: list.length,
        //
        //
        //                 itemBuilder: (context, index) {
        //                   print(index);
        //                   return  list[index].images.length==0? card(post: list[index]):CardWithPicture(post: list[index],image: list[index].images[0]);
        //                 },
        //               );
        //
        //
        //             ListView.builder(
        //               // reverse: true,
        //               // padding: EdgeInsets.only(bottom: 20),
        //               // controller: scrollController,
        //               // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        //               itemCount: list.length,
        //               itemBuilder: (context, index) {
        //
        //                 return   cardShimmer(post: list[index]);
        //               },
        //             );
        //           } else {
        //             return
        //
        //
        //               ListView.builder(
        //                 // reverse: true,
        //                 // padding: EdgeInsets.only(bottom: 20),
        //                 // controller: scrollController,
        //                 // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        //                 itemCount: list.length,
        //                 itemBuilder: (context, index) {
        //
        //                   return   cardShimmer(post: list[index]);
        //                 },
        //               );
        //           }
        //       }
        //     },
        //   ),
        // )

            ;
      },
    )
    ;
  }



  Widget Profile(){
    return  Column(

      children: [

        Stack(
          children: [
            Container(
              width: double.maxFinite,

              height: MediaQuery.of(context).size.height*0.39,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: MediaQuery.of(context).size.height*0.35,
                        margin: const EdgeInsets.symmetric(horizontal: 0),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.black,width: 1),
                            image: const DecorationImage(
                                image: AssetImage("images/pic.jpg"),fit: BoxFit.fill

                            )

                        ),

                      ),
                      Positioned(

                        bottom: 0,

                        right: 0,

                        child: ElevatedButton(

                            style: ElevatedButton.styleFrom(

                              backgroundColor: Colors.white,

                              elevation: 9,

                              shape: const CircleBorder(side: BorderSide(width: 1)),

                            ),

                            onPressed: () async {



                            },

                            child: const Icon(

                              Icons.edit,

                              color: Colors.black,

                            )),

                      )


                    ],
                  ),



                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 20,

              child:   Stack(children: [

                Positioned(
                  child:   Container(
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(90)
                        ,border: Border.all(color: Colors.black,width: 2)

                    ),
                    child: ClipRRect(



                      borderRadius: BorderRadius.circular(90),



                      child: CachedNetworkImage(



                        width:



                        MediaQuery.of(context).size.height * 0.15,



                        height:



                        MediaQuery.of(context).size.height * 0.15,



                        imageUrl: API.auth.currentUser!.photoURL.toString(),



                        fit: BoxFit.contain,



                        placeholder: (context, url) =>



                        const CircularProgressIndicator(



                          color: Colors.black,



                        ),



                        errorWidget: (context, url, error) =>



                        const Icon(Icons.error),



                      ),



                    ),
                  ),

                ),

                Positioned(

                  bottom: 0,

                  right: 0,

                  child: ElevatedButton(

                      style: ElevatedButton.styleFrom(

                        backgroundColor: Colors.white,

                        elevation: 9,

                        shape: const CircleBorder(side: BorderSide(width: 1)),

                      ),

                      onPressed: () async {



                      },

                      child: const Icon(

                        Icons.edit,

                        color: Colors.black,

                      )),

                )





              ],),
            ),

          ],
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,

          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: Text(
                      API.user.displayName.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          height: 1,
                          fontSize: 25,
                          color: Colors.black,
                          fontFamily: "Agbalumo"),
                    ),
                  )
                  ,
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.5,

                    child: Text(API.user.email.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: "CrimsonText")),
                  )

                ],
              ),
              Spacer(),
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
                          Colors.white,
                          Colors.white54,

                          // Colors.white38,
                        ], transform: GradientRotation(90)),
                        borderRadius:
                        BorderRadius.all(Radius.circular(20))),
                    child:

                    const Row(


                      children: [
                        Icon(Icons.edit,color: Colors.black,),
                        SizedBox(width: 10,),
                        Text("Edit Profile",style: TextStyle(

                            color: Colors.black,
                            fontFamily: "Agbalumo"
                        ),)

                      ],
                    )


                ),
              ),

            ],
          ),
        ),
        SizedBox(height: 10,)



      ],
    );


  }
  StyleItems() {
    return const TextStyle(
        fontWeight: FontWeight.w500,
        height: 1,
        fontSize: 20,
        color: Colors.black,
        fontFamily: "VarelaRound");
  }
  Widget card(Post post){
    return Container(
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
                      IconButton(
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
                          icon: const Icon(Icons.cancel)),
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
  Widget cardShimmer(Post post){
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
  Widget CardWithPicture(Post post,String image){
    return  SizedBox(
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
                      IconButton(
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
                          icon: const Icon(Icons.cancel)),
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
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    imageUrl: image,
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


// import 'package:get/get.dart';
//
// class HomeController extends GetxController{
//
//   int counter1=0;
//   int counter2=0;
//
//   void increment1(){
//     counter1++;
//     update();
//
//   }
//   void decrement1(){
//     counter1--;
//
//     update();
//   }
//   void increment2(){
//     counter2++;
//
//     update();
//
//   }
//   void decrement2(){
//     counter2--;
//
//     update();
//   }
//   int get  total=>counter1+counter2;
//
// }

import 'package:get/get.dart';

import '../model/apis/post.dart';

class HomeController extends GetxController{

  RxList<Post> list = <Post>[].obs;
  RxInt counter=0.obs;
  void increament()async{

    counter++;
  }
  @override
  void onInit() async{
   // list.value= await APIs().getAllposts();
    print("${list.length}ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg");

  }



}
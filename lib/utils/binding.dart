import 'package:get/get.dart';
import '../Controller/homeController.dart';

class Binding implements Bindings{
  @override
  void dependencies() {
    Get.put(HomeController(),permanent: true);
// Get.put(APIs());
    // TODO: implement dependencies
  }





}
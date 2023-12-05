import 'package:flutter/material.dart';

class menu extends StatefulWidget {
  const menu({super.key});

  @override
  State<menu> createState() => _menuState();
}

class _menuState extends State<menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
    image: DecorationImage(
    image: AssetImage("images/Curves.jpg"), fit: BoxFit.fill)),
    child: const Scaffold(

      backgroundColor: Colors.transparent,

    ),);
  }
}

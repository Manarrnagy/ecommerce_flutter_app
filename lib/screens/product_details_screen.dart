import 'package:ecommerce_task3/app_colors.dart';
import 'package:ecommerce_task3/app_components.dart';
import 'package:ecommerce_task3/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final List<String> images;
  final String title;
  final String description;
  final double price;
  const ProductDetailsScreen({super.key, required this.images, required this.title, required this.description, required this.price});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:Drawer(
        child: Container(decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(96, 143, 223, 1),
              Color.fromRGBO(230, 239, 255, 1),
              Color.fromRGBO(96, 143, 223, 1),
            ],
          ),
        ),
        child: Column(
          children: [
            CircleAvatar(backgroundColor: AppColors.navyBlue,),
            IconButton(onPressed: ()async{await FirebaseAuth.instance.signOut().whenComplete(() {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);});}, icon: Icon(Icons.logout_rounded),)

          ],
        ),),
      ) ,
      backgroundColor: AppColors.lightGrey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: (){Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back, color: AppColors.navyBlue,)),
            AppComponents.productDetailsContainer(context: context, images: widget.images, title: widget.title, description: widget.description, price: widget.price.toString(),),
          ],
        ),
      ),
    );
  }
}

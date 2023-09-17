import 'package:ecommerce_task3/app_colors.dart';
import 'package:ecommerce_task3/app_components.dart';
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

import 'dart:convert';

import 'package:ecommerce_task3/app_constants.dart';
import 'package:ecommerce_task3/model/product_model.dart';
import 'package:ecommerce_task3/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../app_colors.dart';
import '../app_components.dart';
import '../model/products_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<ProductsResponse> getData() async {
    final response =
    await http.get(Uri.parse("${AppConstants.rootUrl}products"));
    late ProductsResponse productsResponse;
    if (response.statusCode == 200) {
      productsResponse = ProductsResponse.fromJson(jsonDecode(response.body));
    }
    return productsResponse;
  }

  List<Product> productsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      isLoading = true;
      var data = await getData();
      setState(() {
        productsList = data.products!;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppComponents.titleText(
                text: "New Products", align: TextAlign.start),
            isLoading
                ? Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.8,
              child: CircularProgressIndicator(),
            )
                : SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.8,
              child: GridView.builder(
                itemCount: productsList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, i) {
                  return AppComponents.productGridItem(
                    context: context,
                    image: productsList[i].thumbnail!,
                    text: productsList[i].title!,
                    price: productsList[i].price.toString(),
                  callback:()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductDetailsScreen(images: productsList[i].images!, title: productsList[i].title!, description: productsList[i].description!, price: productsList[i].price!.toDouble())))
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

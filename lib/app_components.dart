import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_task3/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';

class AppComponents {
  static Widget bodyText({required String text,
    Color? color,
    TextAlign? align,
    double? size,
    int? maxlines,
    FontWeight? fontWeight}) =>
      Text(
        text,
        textAlign: align ?? TextAlign.center,
        style: GoogleFonts.openSans(
            fontSize: size ?? 15,
            color: color ?? AppColors.mediumGrey,
            fontWeight: fontWeight ?? FontWeight.normal),
        maxLines: maxlines ?? 1,
      );

  static Widget titleText({
    required String text,
    Color? color,
    TextAlign? align,
    double? size,
  }) =>
      Text(
        text,
        textAlign: align ?? TextAlign.center,
        style: GoogleFonts.openSans(
            fontSize: size ?? 25,
            color: color ?? AppColors.navyBlue,
            fontWeight: FontWeight.bold),
      );

  static Widget productGridItem({required BuildContext context,
    required String image,
    required String text,
    required String price,
    required VoidCallback callback}) =>
      InkWell(
        child: Container(
          // clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
          width: MediaQuery
              .of(context)
              .size
              .width * 0.30,
          height: MediaQuery
              .of(context)
              .size
              .height * 0.33,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.18,
                    alignment: Alignment.center,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      image: DecorationImage(
                          image: NetworkImage(image), fit: BoxFit.contain),
                    ),
                    //child: Image.network(image,height: MediaQuery.of(context).size.height*0.2,fit: BoxFit.fill,),
                  ),
                  Positioned(
                    right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.02,
                    top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.01,
                    child: SvgPicture.asset("assets/images/ic_heart.svg"),
                  )
                ],
              ),
              bodyText(
                text: text,
              ),
              bodyText(
                  text: "\$$price",
                  color: AppColors.navyBlue,
                  fontWeight: FontWeight.bold,
                  size: 18)
            ],
          ),
        ),
        onTap: callback,
      );

  static Widget productDetailsContainer({
    required BuildContext context,
    required List<String> images,
    required String title,
    required String description,
    required String price,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        height: MediaQuery
            .of(context)
            .size
            .height * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                disableCenter: true,
              ),
              items: images
                  .map(
                    (item) =>
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        //image: DecorationImage(image: NetworkImage(images[1]))
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child:
                      Image.network(item, fit: BoxFit.cover, width: 1000),
                    ),
              )
                  .toList()
                  .toList(),
            ),
            titleText(text: title),
            bodyText(text: description),
            titleText(text: "\$$price", size: 18),
          ],
        ),
      );

  static Widget customFormField

  (

  {

  required

  TextEditingController

  fieldController,
  required String hint,
  required String? validatorString(String val),
  required BuildContext context,
  TextInputType? textInputType

  ,
}) =>
Container
(
margin: EdgeInsets.symmetric(vertical: 7),
height: MediaQuery.of(context).size.height * 0.075,
child: TextFormField(
controller: fieldController,
keyboardType: textInputType ?? TextInputType.name,
validator: (value) {
if (value == "") {
return "Field cant be empty";
} else {
return validatorString(value.toString());
}
},
decoration: InputDecoration(
fillColor: AppColors.lightGrey,
filled: true,
//border: InputBorder.none,
enabledBorder: OutlineInputBorder(
borderSide:
BorderSide(width: 1, color: AppColors.borderLightGrey),
borderRadius: BorderRadius.circular(10.0),
),
enabled: true,
hintText: hint,
hintStyle: TextStyle(
color: AppColors.hintMediumGrey,
fontWeight: FontWeight.normal)),
),
);

static Widget solidButton(
{required VoidCallback fun,
required Widget widget,
required BuildContext context,
double? widthPercent,
Color? color}) =>
InkWell(
onTap: fun,
child: Container(
height: MediaQuery.of(context).size.height * 0.08,
width: MediaQuery.of(context).size.width * 0.87,
alignment: Alignment.center,
decoration: BoxDecoration(
color: AppColors.darkPurple,
borderRadius: BorderRadius.all(Radius.circular(10))),
child: widget,
),
);

static Widget borderedContainer(
{required Widget widget,
required double widthPercent,
required double heightPercent,
required BuildContext context,
VoidCallback? funOnTap}) =>
InkWell(
onTap: funOnTap??(){},
child: Container(
width: MediaQuery.of(context).size.width * widthPercent,
height: MediaQuery.of(context).size.height * heightPercent,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(10),
border: Border.all(color: AppColors.borderLightGrey, width: 1)),
child: widget,
),
);

static Widget textBetweenDiv({required Widget widget}) => Row(
children: [
Expanded(
child: Divider(color: AppColors.borderLightGrey),
),
widget,
Expanded(
child: Divider(
color: AppColors.borderLightGrey,
),
),
]
,
);
}

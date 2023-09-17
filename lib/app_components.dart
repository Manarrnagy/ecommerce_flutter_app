import 'package:ecommerce_task3/app_colors.dart';
import 'package:flutter/material.dart';
import'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';

class AppComponents{

  static Widget bodyText({required String text, Color? color, TextAlign? align, double? size, FontWeight? fontWeight}) => Text(
    text,
    textAlign: align?? TextAlign.center,
    style: GoogleFonts.openSans(
        fontSize: size?? 15, color: color ?? AppColors.mediumGrey, fontWeight: fontWeight?? FontWeight.normal),
  );

  static Widget titleText({required String text, Color? color,TextAlign? align,}) => Text(
    text,
    textAlign: align?? TextAlign.center,
    style: GoogleFonts.openSans(
        fontSize: 25,
        color: color ?? AppColors.navyBlue,
        fontWeight: FontWeight.bold),
  );

  static Widget productGridItem(
      {required BuildContext context, required String image,
        required String text,
        required String price}) =>
      Container(
        margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
        width: MediaQuery.of(context).size.width*0.33,
        height: MediaQuery.of(context).size.height*0.33,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.18,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    image: DecorationImage(image: NetworkImage(image),fit: BoxFit.contain)
                  ),
                 // child: Image.network(image,height: MediaQuery.of(context).size.height*0.2,fit: BoxFit.fill,),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width*0.02,
                  top: MediaQuery.of(context).size.height*0.01,
                  child: SvgPicture.asset("assets/images/ic_heart.svg"),)
              ],
            ),
            bodyText(text: text),
            bodyText(text: "\$$price", color: AppColors.navyBlue, fontWeight: FontWeight.bold, size: 18 )

          ],
        ),
      );

}
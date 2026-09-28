import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylish/core/constants/image_assets.dart';

class StylishLogo extends StatelessWidget {
  const StylishLogo({super.key, this.height,this.width });

  final double? height;
  final double? width;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(AppImages.fulllogo, height:height ,width: width,)
        
      ],
    );
  }
}

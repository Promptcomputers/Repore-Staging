import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repore/src/components/app_text_theme.dart';
import 'package:repore/src/components/color/value.dart';

class FormLabel extends StatelessWidget {
  final String text;
  const FormLabel({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyle.satoshiFontText(
        context,
        AppColors.primaryTextColor,
        14.sp,
      ),
    );
  }
}

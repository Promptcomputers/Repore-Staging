import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repore/lib.dart';

class HomeQuickActionWidget extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String subTitle;
  final String buttonText;
  final void Function() onTap;
  final bool showButton;
  const HomeQuickActionWidget({
    Key? key,
    required this.imgUrl,
    required this.title,
    required this.subTitle,
    required this.buttonText,
    required this.onTap,
    this.showButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding:
          EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.homeContainerBorderColor,
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.homeContainerBorderColor,
            blurRadius: 3.r,
            // spreadRadius: 10.r,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imgUrl,
            color: AppColors.buttonBgColor,
            width: 20.w,
            height: 20.h,
          ),
          YBox(15),
          Text(
            title,
            style: AppTextStyle.josefinSansFont(
                context, AppColors.headerTextColor1, 16.sp,
                fontWeight: FontWeight.w600),
          ),
          YBox(10),
          Text(
            subTitle,
            style: AppTextStyle.satoshiFontText(
              context,
              AppColors.headerTextColor1,
              14.sp,
            ),
          ),
          YBox(20),
          !showButton
              ? SizedBox()
              : GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    decoration: BoxDecoration(
                      color: AppColors.buttonBgColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text(
                        buttonText,
                        style: AppTextStyle.interFontText(
                          context,
                          AppColors.buttonBgColor,
                          14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

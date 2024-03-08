import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repore/lib.dart';

class EmptyNotificationStateWidget extends StatelessWidget {
  final String? message;
  const EmptyNotificationStateWidget({
    this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.notificationEmptyImage),
          Text(
            'Nothing to see here',
            style: AppTextStyle.josefinSansFont(
              context,
              AppColors.notificationHeaderColor,
              20.sp,
            ),
          ),
          YBox(10),
          Text(
            message ?? 'There are no notifications here yet',
            style: AppTextStyle.satoshiFontText(
              context,
              AppColors.headerTextColor1,
              14.sp,
            ),
          ),
        ],
      ),
    );
  }
}

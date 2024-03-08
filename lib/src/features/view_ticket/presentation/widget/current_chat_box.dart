import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repore/lib.dart';

class CurrentUserChatBox extends StatelessWidget {
  final String msg;
  final String dateCreated;
  final String userName;
  final String attachment;
  const CurrentUserChatBox({
    required this.msg,
    required this.dateCreated,
    required this.userName,
    required this.attachment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Container(
            // constraints: BoxConstraints(
            //   maxWidth: MediaQuery.of(context).size.width * 0.9,
            // ),
            padding: EdgeInsets.only(
                left: attachment.isNotEmpty ? 8.w : 12.w,
                right: attachment.isNotEmpty ? 8.w : 12.w,
                top: 10.h,
                bottom: 10.h),
            decoration: BoxDecoration(
              color: AppColors.buttonBgColor2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(20.r),
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      capitalizeFirstLetter(userName),
                      style: AppTextStyle.satoshiFontText(
                        context,
                        AppColors.homeContainerBorderColor,
                        14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Spacer(),
                    XBox(15.w),
                    Text(
                      dateCreated,
                      style: AppTextStyle.satoshiFontText(
                        context,
                        AppColors.textFormFieldBorderColor,
                        12.sp,
                      ),
                    ),
                  ],
                ),
                YBox(5),
                if (attachment.isNotEmpty) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        width: 3.w,
                        color: AppColors.primaryColor.withOpacity(0.4),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: CachedNetworkImage(
                        width: 140.w,
                        height: 130.h,
                        fit: BoxFit.cover,
                        imageUrl: "${AppConfig.imgStorageUrl}$attachment",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
                YBox(attachment.isNotEmpty ? 5 : 0),
                if (msg.isNotEmpty) ...[
                  Text(
                    msg,
                    style: AppTextStyle.satoshiFontText(
                      context,
                      AppColors.homeContainerBorderColor,
                      14.sp,
                    ),
                    softWrap: true,
                  ),
                ],
              ],
            ),
          ),
        ),
        XBox(5),
        Flexible(
          child: Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: AppColors.buttonBgColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                getStringFirstLetter(userName.toUpperCase()),
                style: AppTextStyle.satoshiFontText(
                  context,
                  AppColors.buttonBgColor,
                  14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

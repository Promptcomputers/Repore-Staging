import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:repore/lib.dart';

class AgentChatBox extends StatelessWidget {
  final String msg;
  final String dateCreated;
  final String userName;
  final String role;
  final String type;
  final String invoiceId;
  final num? invoiceTotal;
  final String subject;
  final String invoiceType;
  // final bool hideSenderInfo;
  // final String attachment;
  const AgentChatBox({
    required this.msg,
    required this.dateCreated,
    required this.userName,
    required this.role,
    required this.type,
    // required this.attachment,
    required this.invoiceId,
    required this.invoiceTotal,
    required this.subject,
    required this.invoiceType,
    // required this.hideSenderInfo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == "NOTIFICATION"
        ? Column(
            //Harded coded the column to solve the width issue, to resolve later
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 7.h, bottom: 7.h),
                width: 250.w,
                decoration: BoxDecoration(
                  color: AppColors.notificationCardColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    capitalizeFirstLetter(msg),
                    style: AppTextStyle.satoshiFontText(
                        context, AppColors.textRedColor, 12.sp),
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // if (!hideSenderInfo)
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
                      role == 'ADMIN' || role.isEmpty
                          ? "R"
                          : getStringFirstLetter(userName.toUpperCase()),
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
              XBox(5),
              if (type == "INVOICE") ...[
                GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      AppRoute.invoicePreviewScreen.name,
                      queryParams: {
                        'invoiceId': invoiceId,
                        'invoiceRef': '',
                        'subject': subject
                      },
                    );
                  },
                  child: Flexible(
                    child: Container(
                      // constraints: BoxConstraints(
                      //     maxWidth: MediaQuery.of(context).size.width * 0.5),
                      // BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                      padding: EdgeInsets.only(
                          left: 12.w, right: 12.w, top: 10.h, bottom: 10.h),
                      decoration: BoxDecoration(
                        color: AppColors.homeContainerBorderColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.r),
                          topRight: Radius.circular(20.r),
                          bottomLeft: Radius.circular(20.r),
                          bottomRight: Radius.circular(20.r),
                        ),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              dateCreated,
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.primaryTextColor2,
                                12.sp,
                              ),
                            ),
                          ),
                          YBox(3),
                          Container(
                            padding: EdgeInsets.only(
                                left: 10.w,
                                right: 10.w,
                                top: 15.h,
                                bottom: 15.h),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  invoiceType == "SERVICE"
                                      ? AppIcon.invoiceServiceIcon
                                      : AppIcon.invoiceAcquistionIcon,
                                  width: 25.w,
                                  height: 25.h,
                                ),
                                XBox(4),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Text(
                                        subject,
                                        style: AppTextStyle.satoshiFontText(
                                          context,
                                          AppColors.buttonBgColor2,
                                          16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      invoiceTotal == 0 || invoiceTotal == null
                                          ? '0'
                                          : formatCurrency(
                                              invoiceTotal.toString()),
                                      style: AppTextStyle.satoshiFontText(
                                        context,
                                        AppColors.headerTextColor1,
                                        12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Flexible(
                  child: Container(
                    // width: MediaQuery.of(context).size.width - 100,
                    // constraints: BoxConstraints(
                    //   maxWidth: (MediaQuery.of(context).size.width - 100),
                    // ),
                    // BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    padding: EdgeInsets.only(
                        left: 12.w, right: 12.w, top: 10.h, bottom: 10.h),
                    decoration: BoxDecoration(
                      color: AppColors.homeContainerBorderColor,
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
                              role == 'ADMIN' || role.isEmpty
                                  ? "Repore Admin"
                                  : capitalizeFirstLetter(userName),
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.headerTextColor2,
                                14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            // XBox(15.w),
                            Text(
                              dateCreated,
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.primaryTextColor2,
                                12.sp,
                              ),
                            ),
                          ],
                        ),
                        YBox(5),
                        // if (attachment.isNotEmpty) ...[
                        //   Container(
                        //     decoration: BoxDecoration(
                        //       color: AppColors.primaryColor.withOpacity(0.4),
                        //       borderRadius: BorderRadius.circular(8.r),
                        //       border: Border.all(
                        //         width: 3.w,
                        //         color: AppColors.primaryColor.withOpacity(0.4),
                        //       ),
                        //     ),
                        //     child: ClipRRect(
                        //       borderRadius: BorderRadius.circular(8.r),
                        //       child: CachedNetworkImage(
                        //         width: 140.w,
                        //         height: 130.h,
                        //         fit: BoxFit.cover,
                        //         imageUrl:
                        //             "https://storage-promptcomputers.s3.us-east-2.amazonaws.com/1691615570112",
                        //         progressIndicatorBuilder:
                        //             (context, url, downloadProgress) => Center(
                        //           child: CircularProgressIndicator(
                        //               value: downloadProgress.progress),
                        //         ),
                        //         errorWidget: (context, url, error) => const Icon(
                        //           Icons.error,
                        //           color: Colors.red,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ],
                        // YBox(attachment.isNotEmpty ? 5.h : 0.h),
                        // if (msg.isNotEmpty) ...[
                        //   Text(
                        //     msg,
                        //     // 'Hello, let get to work, SO that if you will get bet ethebe ieu he  ejbsgjkbkdjh dfhihi S',
                        //     style: AppTextStyle.bodyText(
                        //       context,
                        //       AppColors.homeContainerBorderColor,
                        //       12.sp,
                        //     ),
                        //     softWrap: true,
                        //   ),
                        // ],
                        //  if (attachment.isNotEmpty) ...[
                        //   CachedNetworkImage(
                        //     width: 64.w,
                        //     height: 64.h,
                        //     fit: BoxFit.cover,
                        //     imageUrl:
                        //         "https://storage-promptcomputers.s3.us-east-2.amazonaws.com/$attachment",
                        //     progressIndicatorBuilder: (context, url, downloadProgress) =>
                        //         Center(
                        //       child: CircularProgressIndicator(
                        //           value: downloadProgress.progress),
                        //     ),
                        //     errorWidget: (context, url, error) => const Icon(
                        //       Icons.error,
                        //       color: Colors.red,
                        //     ),
                        //   ),
                        // ],
                        // Text(
                        //   'Add a very long text the goes a few lines fffff',
                        //   style: TextStyle(fontSize: 16, color: Colors.black),
                        //   softWrap: true,
                        //   overflow: TextOverflow.visible,
                        // ),
                        Text(
                          // 'hi',
                          msg,
                          style: AppTextStyle.satoshiFontText(
                            context,
                            AppColors.headerTextColor2,
                            14.sp,
                          ),
                          // overflow: TextOverflow.ellipsis,

                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
  }
}

// class AgentChatBox extends StatelessWidget {
//   final String msg;
//   final String dateCreated;
//   final String userName;
//   const AgentChatBox({
//     required this.msg,
//     required this.dateCreated,
//     required this.userName,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         //TODO: Hide time if the time is same e.g 22.55 a message was send, and another message sent by the same user by that time
//         // dateCreated == dateCreated
//         //     ? const SizedBox()
//         //     :
//         Row(
//           children: [
//             Container(
//               width: 32.w,
//               height: 32.h,
//               decoration: BoxDecoration(
//                 color: AppColors.buttonBgColor.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//               child: Center(
//                 child: Text(
//                   getStringFirstLetter(userName.toUpperCase()),
//                   // '${getStringFirstLetter(userVm.asData!.value.data!.firstname!.toUpperCase())}${getStringFirstLetter(userVm.asData!.value.data!.lastname!.toUpperCase())}',
//                   // 'MD',
//                   style: AppTextStyle.headerTextStyle(
//                     context,
//                     AppColors.buttonBgColor,
//                     20.sp,
//                   ),
//                 ),
//               ),
//             ),
//             XBox(5.h),
//             Text(
//               userName,
//               style: AppTextStyle.bodyText(
//                 context,
//                 AppColors.notificationHeaderColor,
//                 14.sp,
//               ),
//             ),
//             XBox(10.h),
//             Text(
//               dateCreated,
//               style: AppTextStyle.bodyText(
//                 context,
//                 AppColors.primaryTextColor2,
//                 14.sp,
//               ),
//             ),
//           ],
//         ),
//         YBox(5.h),
//         Container(
//           constraints:
//               BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
//           margin: EdgeInsets.only(
//             left: 40.w,
//           ),
//           padding:
//               EdgeInsets.only(left: 12.w, right: 12.w, top: 10.h, bottom: 10.h),
//           decoration: BoxDecoration(
//             color: AppColors.buttonBgColor,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(0.r),
//               topRight: Radius.circular(20.r),
//               bottomLeft: Radius.circular(20.r),
//               bottomRight: Radius.circular(20.r),
//             ),
//           ),
//           child: Text(
//             msg,
//             // 'Hello, let get to work',
//             style: AppTextStyle.bodyText(
//               context,
//               AppColors.chatTextColor,
//               14.sp,
//             ),
//             softWrap: true,
//           ),
//         )
//       ],
//     );
//   }
// }

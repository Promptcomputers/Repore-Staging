import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repore/lib.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  // final BuildContext menuScreenContext;
  // final Function onScreenHideButtonPressed;
  // final bool hideStatus;
  const NotificationScreen(
      {
      //   required this.menuScreenContext,
      // required this.onScreenHideButtonPressed,
      // required this.hideStatus,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(getNofificationProvider);

    ref.listen<AsyncValue>(markNotificationAsRedProvider, (T, value) {
      if (value.hasValue) {
        ref.invalidate(getNofificationProvider);
      }
      if (value.hasError) {}
    });
    ref.listen<AsyncValue>(markAllNotificationProvider, (T, value) {
      if (value.hasValue) {
        ref.invalidate(getNofificationProvider);

        context.loaderOverlay.hide();
      }
      if (value.hasError) {
        context.loaderOverlay.hide();
        ref.invalidate(getNofificationProvider);
      }
    });

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(getNofificationProvider);
      },
      child: Scaffold(
        backgroundColor: AppColors.primarybgColor,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Row(
                children: [
                  Image.asset(AppImages.checkMark),
                  XBox(5),
                  GestureDetector(
                    onTap: () {
                      ref
                          .read(markAllNotificationProvider.notifier)
                          .markAllNotificationAsRead();
                      context.loaderOverlay.show();
                    },
                    child: Text(
                      'Mark all as read',
                      style: AppTextStyle.satoshiFontText(
                        context,
                        AppColors.buttonBgColor,
                        14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          title: Text(
            'Notifications',
            style: AppTextStyle.josefinSansFont(
              context,
              AppColors.homeContainerBorderColor,
              20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.primaryColor, // <-- SEE HERE
            statusBarIconBrightness:
                Brightness.light, //<-- For Android SEE HERE (dark icons)
            statusBarBrightness:
                Brightness.dark, //<-- For iOS SEE HERE (dark icons)
          ),
        ),
        body: SafeArea(
          child: vm.when(
            data: (value) {
              return value.data.isEmpty
                  ? EmptyNotificationStateWidget()
                  : ListView.separated(
                      padding:
                          EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.data.length,
                      itemBuilder: (context, index) {
                        // if (value.data.isEmpty) {
                        //   EmptyNotificationStateWidget();
                        // }
                        final item = value.data[index];

                        // return value.data.isEmpty
                        //     ? const EmptyNotificationStateWidget()
                        //     :
                        return NotificationListWidget(
                          // imgUrl: item.imgUrl,
                          title: item.title,
                          subtitle: item.description,
                          isRead: item.status,
                          onTap: () {
                            // 651c18d546e3f527b1efb1f3
                            if (item.status == false) {
                              ///Only mark notification read is it has not been read
                              ref
                                  .read(markNotificationAsRedProvider.notifier)
                                  .markNotificationAsRead(item.id);
                            }
                            // if (item.title == 'Invoice Rejected') {
                            //   context.pushNamed(
                            //     AppRoute.invoicePreviewScreen.name,
                            //     queryParams: {
                            //       'invoiceId': item.metadata!.invoice,
                            //       'invoiceRef': '',
                            //       'subject': item.metadata!.subject,
                            //     },
                            //   );
                            // }

                            ///Direct user to ticket screen
                            /////TODO: metadata retun empty when you are not clicking on invoice
                            if (item.metadata!.ticket.isNotEmpty) {
                              context.pushNamed(
                                AppRoute.viewTicketScreen.name,
                                queryParams: {
                                  'id': item.metadata!.ticket,
                                  'ref': '',
                                  'title': item.metadata!.subject,
                                },
                              );
                            }

                            ///Direct user to invoice preview screen
                            if (item.metadata!.invoice.isNotEmpty) {
                              context.pushNamed(
                                AppRoute.invoicePreviewScreen.name,
                                queryParams: {
                                  'invoiceId': item.metadata!.invoice,
                                  'invoiceRef': '',
                                  'subject': item.metadata!.subject,
                                },
                              );
                            }
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return YBox(20.h);
                      },
                    );
            },
            error: (error, stackTrace) => Text(
              error.toString(),
              style: AppTextStyle.satoshiFontText(
                context,
                AppColors.buttonBgColor,
                14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            // error: (error, stackTrace) => const SizedBox(),
            loading: () => const AppCircularLoading(),
          ),
        ),
      ),
    );
  }
}

class NotificationListWidget extends StatelessWidget {
  // final String imgUrl;
  final String title;
  final String subtitle;
  final bool isRead;
  final void Function() onTap;
  const NotificationListWidget({
    Key? key,
    // required this.imgUrl,
    required this.title,
    required this.subtitle,
    required this.isRead,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 25.h, bottom: 25.h),
        decoration: BoxDecoration(
          color: isRead == true
              ? AppColors.notificationReadColor
              : AppColors.notificationCardBorderColor.withOpacity(0.3),
          border: Border.all(
            width: 0.5.w,
            color: isRead == true
                ? AppColors.notificationReadColor
                : AppColors.notificationCardColor,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    // const SizedBox(),
                    Image.asset(AppImages.notificationMatchImage),
                    XBox(10),
                    Text(
                      title,
                      style: AppTextStyle.josefinSansFont(
                        context,
                        AppColors.primaryTextColor,
                        16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Row(
                    children: [
                      Text(
                        'View',
                        style: AppTextStyle.satoshiFontText(
                          context,
                          AppColors.headerTextColor1,
                          14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      XBox(2),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.headerTextColor1,
                          size: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            YBox(5),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 60.w),
              child: Text(
                subtitle,
                style: AppTextStyle.satoshiFontText(
                  context,
                  AppColors.headerTextColor1,
                  14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Notification {
  final String imgUrl;
  final String title;
  final String subtitle;
  final bool isRead;

  Notification({
    required this.imgUrl,
    required this.title,
    required this.subtitle,
    required this.isRead,
  });
}

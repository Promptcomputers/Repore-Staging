import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

class TicketCreatedBottomSheet extends ConsumerWidget {
  const TicketCreatedBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.invalidate(searchTicketProvider);
    ref.invalidate(getNofificationProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 90.h),
          padding:
              EdgeInsets.only(left: 24.w, right: 24.w, top: 27.h, bottom: 27.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFDFDFD),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
              bottomLeft: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r),
            ),
          ),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.buttonBgColor.withOpacity(0.1),
                child: Image.asset(AppIcon.ticketCreatedIcon),
              ),
              YBox(10),
              Text(
                'Ticket Created 🎉',
                style: AppTextStyle.interFontText(
                  context,
                  AppColors.notificationHeaderColor,
                  16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              YBox(10),
              Text(
                'Grab a glass of whatever you enjoy, and we’ll match you with an agent soon',
                style: AppTextStyle.interFontText(
                  context,
                  AppColors.headerTextColor1,
                  14.sp,
                ),
                textAlign: TextAlign.center,
              ),
              YBox(20),
              Row(
                children: [
                  SizedBox(
                    width: 140.w,
                    child: AppButton(
                      buttonText: 'Close',
                      onPressed: () {
                        Navigator.pop(context);
                        // context.pop();
                      },
                      bgColor: AppColors.headerTextColor2.withOpacity(0.1),
                      textColor: AppColors.headerTextColor2,
                      borderColor: AppColors.headerTextColor2.withOpacity(0.1),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 140.w,
                    child: AppButton(
                      buttonText: 'View Ticket',
                      onPressed: () {
                        Navigator.pop(context);
                        context.pushNamed(
                          AppRoute.viewTicketScreen.name,
                          queryParams: {
                            'id': PreferenceManager.ticketId,
                            'ref': PreferenceManager.ticketRef,
                            'title': PreferenceManager.ticketTitle,
                          },
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

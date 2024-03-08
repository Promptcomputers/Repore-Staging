import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:repore/lib.dart';

class CompleteProfileScreen extends ConsumerStatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends ConsumerState<CompleteProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(getUserDetailsProvider);
    final cardVm = ref.watch(getCardsProvider);

    return Scaffold(
      backgroundColor: AppColors.primarybgColor,
      appBar: AppBar(
        toolbarHeight: 10.h,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
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
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  ///TODO: Temporary fixed
                  ref.invalidate(getUserDetailsProvider);
                  context.pop();
                },
                child: Image.asset(AppIcon.backArrowIcon),
              ),
              YBox(5),
              Text(
                'Complete profile',
                style: AppTextStyle.satoshiFontText(
                  context,
                  AppColors.notificationHeaderColor,
                  20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              YBox(5),
              Text(
                'You are almost there',
                style: AppTextStyle.satoshiFontText(
                  context,
                  AppColors.headerTextColor2,
                  14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              YBox(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LinearPercentIndicator(
                    percent: percentage(
                        (vm.asData?.value.data.isPinProvided ?? true),
                        (vm.asData?.value.data.isAddressComplete ?? true),
                        (vm.asData?.value.data.isCardProvided ?? true)),
                    width: 290.w,
                    lineHeight: 13.0,
                    barRadius: Radius.circular(4.r),
                    progressColor: AppColors.primaryColor2,
                    backgroundColor: AppColors.notificationReadCardColor,
                    padding: EdgeInsets.symmetric(horizontal: 0.0),
                  ),
                  Text(
                    percentageText(
                        (vm.asData?.value.data.isPinProvided ?? true),
                        (vm.asData?.value.data.isAddressComplete ?? true),
                        (vm.asData?.value.data.isCardProvided ?? true)),
                    style: AppTextStyle.satoshiFontText(
                      context,
                      AppColors.primaryTextColor,
                      14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              YBox(20),
              CompleteProfileQuickActionWidget(
                icon: AppIcon.profileInfoIcon,
                title: 'Profile info',
                subtitle: 'For our agents to easily reach you',
                isVerified: (vm.asData?.value.data.isAddressComplete ?? true),
                onTap: () {
                  showModalBottomSheet(
                    // backgroundColor: Colors.transparent,
                    barrierColor: AppColors.primaryTextColor.withOpacity(1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0.sp),
                      ),
                    ),
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => const AddAdressBottomSheet(),
                  );
                },
              ),
              YBox(20),
              CompleteProfileQuickActionWidget(
                icon: AppIcon.securityIcon,
                title: 'Add pin',
                subtitle: 'To safely carry out transactions ',
                isVerified: (vm.asData?.value.data.isPinProvided ?? true),
                onTap: ((vm.asData?.value.data.isAddressComplete ?? true) ==
                            false ||
                        (vm.asData?.value.data.isPinProvided ?? true) == true)
                    ? null
                    : () {
                        context.pushNamed(AppRoute.createPinScreen.name,
                            params: {"isFromComplete": '1'});
                      },
              ),
              YBox(20),
              CompleteProfileQuickActionWidget(
                icon: AppIcon.walletIcon,
                title: 'Add payment method',
                subtitle: 'Pay with a debit or credit card',
                isVerified: (cardVm.asData?.value.isNotEmpty == true),
                onTap: (vm.asData?.value.data.isPinProvided ?? true) == false
                    ? null
                    : () {
                        showModalBottomSheet(
                          // backgroundColor: Colors.transparent,
                          barrierColor:
                              AppColors.primaryTextColor.withOpacity(1.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.0.sp),
                            ),
                          ),
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => const AddCardBottomSheet(),
                        );
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

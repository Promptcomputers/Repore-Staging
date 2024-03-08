import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

class PaymentMethodScreen extends ConsumerStatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends ConsumerState<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(getCardsProvider);
    ref.listen<AsyncValue>(deleteCardProvider, (T, value) {
      if (value.hasValue) {
        ref.invalidate(getCardsProvider);
      }
      if (value.hasError) {}
    });
    return Scaffold(
      backgroundColor: AppColors.primarybgColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Image.asset(
            AppIcon.backArrowIcon2,
          ),
        ),
        title: Text(
          'Payment Methods',
          style: AppTextStyle.josefinSansFont(
            context,
            AppColors.homeContainerBorderColor,
            20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor, // <-- SEE HERE
          statusBarIconBrightness:
              Brightness.dark, //<-- For Android SEE HERE (dark icons)
          statusBarBrightness:
              Brightness.dark, //<-- For iOS SEE HERE (dark icons)
        ),
      ),
      body: SafeArea(
        child: vm.when(
          error: (error, stackTrace) => const SizedBox(),
          loading: () => const AppCircularLoading(),
          data: (value) {
            return value.isEmpty
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EmptyNotificationStateWidget(
                          message: 'No Card yet',
                        ),
                        YBox(20),
                        SizedBox(
                          width: 150.w,
                          child: AppButton(
                            buttonText: 'Add new card',
                            onPressed: () {
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
                                builder: (context) =>
                                    const AddCardBottomSheet(),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                          itemCount: value.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => YBox(15.h),
                          itemBuilder: (context, index) {
                            final item = value[index];
                            return Container(
                              padding: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                                top: 20.h,
                                bottom: 20.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  width: 1.w,
                                  color: AppColors.homeContainerBorderColor,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(AppIcon.masterCardLogo),
                                          XBox(20),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${capitalizeFirstLetter(item.type)} .... ${item.lastDigits}',
                                                style: AppTextStyle
                                                    .satoshiFontText(
                                                  context,
                                                  AppColors.headerTextColor1,
                                                  14.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                'Expires: ${item.expireDate}',
                                                style: AppTextStyle
                                                    .satoshiFontText(
                                                  context,
                                                  AppColors.headerTextColor1,
                                                  12.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      /// If card is just one, don't show the delete icon
                                      value.length == 1
                                          ? SizedBox()
                                          : GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  // backgroundColor: Colors.transparent,
                                                  barrierColor: AppColors
                                                      .primaryTextColor
                                                      .withOpacity(1.0),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                      top: Radius.circular(
                                                          20.0.sp),
                                                    ),
                                                  ),
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) =>
                                                      DeleteCardBottomSheet(
                                                    cardId: item.id,
                                                  ),
                                                );
                                                // ref
                                                //     .read(deleteCardProvider
                                                //         .notifier)
                                                //     .deleteCard(item.id);
                                              },
                                              child: Image.asset(
                                                AppIcon.deleteIcon,
                                                width: 16.w,
                                                height: 16.h,
                                              ),
                                            ),
                                      // value.length == 1
                                      //     ? SizedBox()
                                      //     : GestureDetector(
                                      //         onTap: () {
                                      //           ref
                                      //               .read(deleteCardProvider
                                      //                   .notifier)
                                      //               .deleteCard(item.id);
                                      //         },
                                      //         child: Icon(
                                      //           Icons.delete,
                                      //           color:
                                      //               AppColors.headerTextColor1,
                                      //         ),
                                      //       ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        YBox(10),
                        GestureDetector(
                          onTap: () {
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
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: AppColors.buttonBgColor2,
                                size: 16.sp,
                              ),
                              XBox(2),
                              Text(
                                'Add new card',
                                style: AppTextStyle.satoshiFontText(
                                  context,
                                  AppColors.buttonBgColor2,
                                  14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class DeleteCardBottomSheet extends ConsumerWidget {
  final String cardId;
  const DeleteCardBottomSheet({super.key, required this.cardId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(deleteCardProvider);
    ref.listen<AsyncValue>(deleteCardProvider, (T, value) {
      if (value.hasValue) {
        Navigator.pop(context);
        showSuccessToast(context, 'Card deleted successfully');
        ref.invalidate(getCardsProvider);
      }
      if (value.hasError) {
        showErrorToast(context, "An error occured, try again later");
      }
    });
    return Container(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 27.h,
        bottom: 30.h,
      ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          YBox(20),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset(
              AppIcon.closeIcon,
              width: 40.w,
              height: 40.h,
            ),
          ),
          YBox(10),
          Text(
            'Delete card?',
            style: AppTextStyle.satoshiFontText(
              context,
              AppColors.notificationHeaderColor,
              16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          YBox(10),
          Text(
            'Are you sure you want to delete?',
            style: AppTextStyle.satoshiFontText(
              context,
              AppColors.headerTextColor1,
              14.sp,
            ),
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
                  borderColor: Colors.transparent,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 140.w,
                child: AppButton(
                  buttonText: 'Delete',
                  bgColor: AppColors.redColor,
                  textColor: AppColors.whiteColor,
                  borderColor: Colors.transparent,
                  isLoading: vm.isLoading,
                  onPressed: vm.isLoading
                      ? null
                      : () {
                          ref
                              .read(deleteCardProvider.notifier)
                              .deleteCard(cardId);
                        },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

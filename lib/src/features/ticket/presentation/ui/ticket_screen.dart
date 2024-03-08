import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

class TicketScreen extends ConsumerStatefulWidget {
  // final BuildContext menuScreenContext;
  // final Function onScreenHideButtonPressed;
  // final bool hideStatus;
  const TicketScreen(
      {
      //   required this.menuScreenContext,
      // required this.onScreenHideButtonPressed,
      // required this.hideStatus,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TicketScreenState();
}

class _TicketScreenState extends ConsumerState<TicketScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(getUserDetailsProvider);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.primarybgColor,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            'Tickets',
            // 'Welcome ${capitalizeFirstLetter(firstName)} 🧺',
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
          child: Column(
            children: [
              (vm.asData?.value.data.isAddressComplete == false) ||
                      (vm.asData?.value.data.isPinProvided == false) ||
                      (vm.asData?.value.data.isCardProvided == false)
                  ? SizedBox()
                  : Padding(
                      padding:
                          EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            //  isScrollControlled: true,
                            // backgroundColor: Colors.transparent,
                            barrierColor:
                                AppColors.primaryColor.withOpacity(0.7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0.sp),
                              ),
                            ),
                            isScrollControlled: true,
                            context: context,
                            builder: (context) =>
                                const CreateTicketBottomSheet(),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: BoxDecoration(
                            color: AppColors.buttonBgColor,
                            borderRadius: BorderRadius.circular(8.r),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: AppColors.primaryColor,
                            //     blurRadius: 2.r,
                            //     spreadRadius: 0.r,
                            //     offset: const Offset(0, 1),
                            //   ),
                            // ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: AppColors.whiteColor,
                                size: 20.sp,
                              ),
                              XBox(5),
                              Text(
                                'New Ticket',
                                style: AppTextStyle.satoshiFontText(
                                  context,
                                  AppColors.whiteColor,
                                  14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              YBox(20),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: AppTextField(
                  controller: _controller,
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(
                      const Duration(seconds: 2),
                      () {
                        // Make your API request here using the text in the TextFormField
                        ref.read(searchTicketProvider.notifier).searchTicket(
                            PreferenceManager.userId, _controller.text.trim());
                      },
                    );
                  },
                  filled: true,
                  filledColor: AppColors.whiteColor,
                  preffixIcon: const Icon(Icons.search),
                  hintText: 'Search ID, ticket...',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: const BorderSide(
                        color: AppColors.homeContainerBorderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: const BorderSide(
                        color: AppColors.homeContainerBorderColor),
                  ),
                ),
              ),
              YBox(20),
              Expanded(child: TicketTabBar()),
            ],
          ),
        ),
      ),
    );
  }
}

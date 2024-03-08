import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:repore/lib.dart';

class CreatePinScreen extends StatefulWidget {
  final String isFromComplete;
  const CreatePinScreen({required this.isFromComplete, super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  String otpCode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.only(top: 100.h, bottom: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.h, right: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Image.asset(AppIcon.backArrowIcon),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.isFromComplete == '1'
                                ? 'Create Pin'
                                : 'Change Pin',
                            style: AppTextStyle.josefinSansFont(
                              context,
                              AppColors.primaryTextColor,
                              24.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Add 4-digit pin',
                            style: AppTextStyle.satoshiFontText(
                              context,
                              AppColors.headerTextColor1,
                              14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    YBox(20.h),
                    Padding(
                      padding: EdgeInsets.only(left: 40.w, right: 40.w),
                      child: PinCodeTextField(
                        errorTextSpace: 32.h,

                        enableActiveFill: true,
                        // backgroundColor: AppColors.secondaryColor3,
                        obscureText: true,
                        appContext: context,
                        cursorColor: AppColors.buttonBgColor2,
                        controller: otpController,
                        length: 4,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter OTP';
                          }
                          return null;
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          inactiveColor: AppColors.notificationReadCardColor,
                          activeColor: AppColors.notificationReadCardColor,
                          selectedColor: AppColors.notificationReadCardColor,
                          selectedFillColor:
                              AppColors.notificationReadCardColor,
                          borderRadius: BorderRadius.circular(8.r),
                          fieldHeight: 50.h,
                          fieldWidth: 50.w,
                          activeFillColor: AppColors.notificationReadCardColor,
                          inactiveFillColor:
                              AppColors.notificationReadCardColor,
                          fieldOuterPadding: const EdgeInsets.all(3),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          Console.print(value);
                          // pinValue = value;
                          // print(pinValue);
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.h, right: 20.h),
                child: AppButton(
                  buttonText: 'Continue',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.pushNamed(AppRoute.confirmCreatePinScreen.name,
                          params: {"pin": otpCode});

                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

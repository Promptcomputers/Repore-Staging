import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:repore/lib.dart';

class RegisterOtpScreen extends ConsumerStatefulWidget {
  final String email;
  const RegisterOtpScreen({required this.email, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterOtpScreenState();
}

class _RegisterOtpScreenState extends ConsumerState<RegisterOtpScreen> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  String otpCode = '';

  @override
  Widget build(BuildContext context) {
    // ref.listen<AsyncValue>(registerProvider, (T, value) {
    //   if (value.hasValue) {
    //     context.pushReplacementNamed(
    //       AppRoute.login.name,
    //     );
    //     showSuccessToast(context, 'Registration successful');
    //     context.loaderOverlay.hide();
    //   }
    //   if (value.hasError) {
    //     context.loaderOverlay.hide();
    //     showErrorToast(context, value.error.toString());
    //   }
    // });
    return LoadingSpinner(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 50.h, bottom: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Image.asset(AppIcon.backArrowIcon),
                        ),
                        YBox(25),
                        Center(
                          child: Text(
                            'Verify Email',
                            style: AppTextStyle.josefinSansFont(
                              context,
                              AppColors.primaryTextColor,
                              24.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        YBox(10),
                        Center(
                          child: Text(
                            'Enter the code sent to ${widget.email}',
                            style: AppTextStyle.satoshiFontText(
                              context,
                              AppColors.headerTextColor1,
                              14.sp,
                            ),
                          ),
                        ),
                        YBox(30),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: PinCodeTextField(
                            errorTextSpace: 32.w,

                            enableActiveFill: true,
                            // backgroundColor: AppColors.secondaryColor3,
                            obscureText: true,
                            appContext: context,
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
                              inactiveColor: AppColors.textFormFieldBorderColor,
                              activeColor: AppColors.textFormFieldBorderColor,
                              selectedColor: AppColors.textFormFieldBorderColor,
                              selectedFillColor: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(8.r),
                              fieldHeight: 50.h,
                              fieldWidth: 50.w,
                              activeFillColor: AppColors.whiteColor,
                              inactiveFillColor: AppColors.whiteColor,
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
                        YBox(9),
                        Align(
                          alignment: Alignment.center,
                          child:
                              // resendOtpVm.isLoading
                              //     ? CircularProgressIndicator.adaptive()
                              //     :
                              RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Didn’t receive a code? ',
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.headerTextColor1,
                                14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // ref
                                      //     .read(forgotPasswordOtpProvider
                                      //         .notifier)
                                      //     .forgotPasswordOtp(
                                      //       widget.email,
                                      //     );
                                    },
                                  text: ' Request again',
                                  style: AppTextStyle.satoshiFontText(
                                    context,
                                    AppColors.buttonBgColor3,
                                    14.sp,
                                    fontWeight: FontWeight.w700,
                                    // decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppButton(
                      // isLoading: vm.isLoading,
                      buttonText: 'Save Changes',
                      onPressed: () {
                        // context.loaderOverlay.show();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

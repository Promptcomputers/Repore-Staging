import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:repore/lib.dart';

class InvoicePaymentSuccessScreen extends StatelessWidget {
  const InvoicePaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
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
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.successBgColor2,
                    child: Icon(
                      Icons.check,
                      color: AppColors.successTextColor,
                    ),
                  ),
                  YBox(5),
                  Text(
                    'Success',
                    style: AppTextStyle.satoshiFontText(
                      context,
                      AppColors.primaryTextColor,
                      20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  YBox(5),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Text(
                      'Your card has been charged and the payment has been received.',
                      style: AppTextStyle.satoshiFontText(
                        context,
                        AppColors.headerTextColor1,
                        16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              AppButton(
                buttonText: 'Back',
                bgColor: AppColors.buttonBgColor2,
                borderColor: AppColors.buttonBgColor2,
                onPressed: () {
                  context.pop();
                  context.pop();
                  // context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

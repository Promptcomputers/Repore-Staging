import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final double height = 742.h;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: bgColor(_current),
        elevation: 0.0,
        toolbarHeight: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: bgColor(_current), // <-- SEE HERE
          statusBarIconBrightness:
              Brightness.light, //<-- For Android SEE HERE (dark icons)
          statusBarBrightness:
              Brightness.light, //<-- For iOS SEE HERE (dark icons)
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    color: bgColor(_current),
                    child: Column(
                      children: [
                        YBox(50),
                        Image.asset(AppImages.logo),
                        YBox(60),
                        CarouselSlider(
                          items: imgList,
                          carouselController: _controller,
                          options: CarouselOptions(
                            viewportFraction: 1.0,
                            autoPlay: true,
                            enlargeCenterPage: false,
                            autoPlayInterval: const Duration(seconds: 5),
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  YBox(25),
                  Padding(
                    padding: EdgeInsets.only(left: 40.w, right: 40.w),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        subText(_current),
                        style: AppTextStyle.josefinSansFont(
                          context,
                          AppColors.headerTextColor2,
                          24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imgList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: _current == entry.key ? 12.w : 12.w,
                            height: _current == entry.key ? 12.h : 12.h,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(
                              //     _current == entry.key ? 55.r : 1.r),
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : AppColors.onboardingDotColor)
                                  .withOpacity(
                                _current == entry.key ? 0.9 : 0.1,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    YBox(10),
                    AppButton(
                      buttonText: 'Create Account',
                      bgColor: AppColors.onboardingDotColor,
                      borderColor: AppColors.onboardingDotColor,
                      onPressed: () {
                        context.pushReplacementNamed(
                          AppRoute.register.name,
                        );
                      },
                    ),
                    YBox(10),
                    AppButton(
                      bgColor: AppColors.whiteColor,
                      borderColor: AppColors.textFormFieldBorderColor,
                      textColor: AppColors.primaryTextColor,
                      buttonText: 'Log In',
                      onPressed: () {
                        context.pushReplacementNamed(
                          AppRoute.login.name,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Widget> imgList = [
  Image.asset(AppImages.onBoardingImg1),
  Image.asset(AppImages.onBoardingImg3),
  Image.asset(AppImages.onBoardingImg2),
];

String subText(int current) {
  if (current == 0) {
    return 'Tailoring Services for your Need';
  }
  if (current == 1) {
    return 'Expertise delivered with Ease';
  }
  if (current == 2) {
    return 'Seamless services at your Fingertips';
  }
  return '';
}

Color bgColor(int current) {
  if (current == 0) {
    return Color(0xFFD9529B).withOpacity(0.1);
  }
  if (current == 1) {
    return Color(0xFF12CCAF).withOpacity(0.1);
  }
  if (current == 2) {
    return Color(0xFFF0FFFD);
  }
  return Color(0xFFD9529B).withOpacity(0.1);
}

Color buttonColor(int current) {
  if (current == 0) {
    return AppColors.buttonBgColor;
  }
  if (current == 1) {
    return AppColors.buttonBgColor;
  }
  if (current == 2) {
    return AppColors.buttonBgColor2;
  }
  return AppColors.buttonBgColor;
}

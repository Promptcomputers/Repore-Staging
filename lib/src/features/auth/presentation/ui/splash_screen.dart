import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

class SplashScreen extends StatefulHookConsumerWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    ref.read(authControllerProvider.notifier).getAuth();

    Future.delayed(const Duration(milliseconds: 5000), () async {
      context.pushReplacementNamed(
        AppRoute.auth.name,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image(
                image: const AssetImage(AppImages.logo2),
                width: 200.w,
                // height: 250.h,
              ),
            ),
            YBox(10),
            Text(
              'Welcome to the neighborhood',
              style: AppTextStyle.josefinSansFont(
                context,
                AppColors.buttonBgColor2,
                16.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

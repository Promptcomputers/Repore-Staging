import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repore/lib.dart';
import 'package:skeletons/skeletons.dart';

class TicketLoadingLoadingState extends StatelessWidget {
  const TicketLoadingLoadingState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 2,
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        itemBuilder: (context, index) {
          return Container(
            height: 150.h,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                borderRadius: BorderRadius.circular(16.r),
                width: double.infinity,
                minHeight: MediaQuery.of(context).size.height / 8,
                maxHeight: MediaQuery.of(context).size.height / 3,
              ),
            ),
          );
        },
      ),
    );
  }
}

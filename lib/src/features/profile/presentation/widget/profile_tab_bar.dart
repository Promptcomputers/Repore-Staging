import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repore/lib.dart';

class ProfileTabBar extends StatefulWidget {
  final List<Widget> tabsText;
  final List<Widget> tabViews;
  const ProfileTabBar(
      {required this.tabViews, required this.tabsText, super.key});

  @override
  State<ProfileTabBar> createState() => _ProfileTabBarState();
}

class _ProfileTabBarState extends State<ProfileTabBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
            ),
            height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: AppColors.whiteColor,
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: 30.w, right: 30.w, top: 5.h, bottom: 5.h),
                height: 60.h,
                width: MediaQuery.of(context).size.width,
                child: TabBar(
                  isScrollable: false,
                  controller: _tabController,
                  labelColor: AppColors.buttonBgColor,
                  labelStyle: AppTextStyle.satoshiFontText(
                    context,
                    AppColors.headerTextColor1,
                    14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelStyle: AppTextStyle.satoshiFontText(
                    context,
                    AppColors.headerTextColor1,
                    14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelColor: AppColors.headerTextColor1,
                  labelPadding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    // color: AppColors.profileTabBgColor,
                    color: AppColors.buttonBgColor.withOpacity(0.3),
                  ),
                  tabs: widget.tabsText,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: 27.h),
              SizedBox(
                width: MediaQuery.of(context).size.width,

                height: 600.h,
                // color: Colors.grey,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: widget.tabViews,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

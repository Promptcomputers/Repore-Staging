import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repore/lib.dart';
import 'package:repore/src/features/ticket/presentation/widget/completed_tab_view.dart';
import 'package:repore/src/features/ticket/presentation/widget/ongoing_ticket_tab_view.dart';
import 'package:repore/src/features/ticket/presentation/widget/pending_ticket_tab_view.dart';

class TicketTabBar extends StatefulWidget {
  const TicketTabBar({super.key});

  @override
  State<TicketTabBar> createState() => _TicketTabBarState();
}

class _TicketTabBarState extends State<TicketTabBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                // height: 40.h,
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                ),
                width: MediaQuery.of(context).size.width,

                child: TabBar(
                  isScrollable: false,
                  controller: _tabController,
                  labelColor: AppColors.buttonBgColor,
                  labelStyle: AppTextStyle.satoshiFontText(
                    context,
                    AppColors.headerTextColor1,
                    14.sp,
                  ),
                  unselectedLabelStyle: AppTextStyle.satoshiFontText(
                    context,
                    AppColors.headerTextColor1,
                    14.sp,
                  ),
                  unselectedLabelColor: AppColors.headerTextColor1,
                  labelPadding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.buttonBgColor.withOpacity(0.2),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: AppColors.primarybgColor,
                  tabs: const [
                    Tab(
                      child: Text(
                        'All',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Ongoing',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Pending',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Completed',
                      ),
                    ),
                  ],
                ),
              ),
              YBox(10),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    AllTicketTabView(),
                    OnGoingTicketTabView(),
                    PendingTicketTabView(),
                    CompletedTicketTabView(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DemoTabView extends StatelessWidget {
  final String text;
  const DemoTabView({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: AppTextStyle.satoshiFontText(
          context,
          AppColors.primaryTextColor2,
          12.sp,
        ),
      ),
    );
  }
}

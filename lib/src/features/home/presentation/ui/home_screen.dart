import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:repore/lib.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final void Function(AutoScrollController) onControllerSet;
  final void Function()? switchToTicketFn;
  const HomeScreen(
      {required this.onControllerSet,
      required this.switchToTicketFn,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  AutoScrollController? scrollController;

  String secretClientKey = '';
  @override
  void initState() {
    // ref.read(getUserDetailsProvider);
    scrollController = AutoScrollController();
    widget.onControllerSet(scrollController!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(getServiceTypeProvider);
    final vm = ref.watch(getUserDetailsProvider);

    return LoadingSpinner(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: _key,
          backgroundColor: AppColors.primarybgColor,
          appBar: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Text(
              'Welcome ${capitalizeFirstLetter(PreferenceManager.firstName)}',
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
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(getUserDetailsProvider);
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///For new user that hasn't completed their profile
                      (vm.asData?.value.data.isAddressComplete == false) ||
                              (vm.asData?.value.data.isPinProvided == false) ||
                              // (cardVm.asData?.value.isEmpty == true)
                              (vm.asData?.value.data.isCardProvided == false)
                          ? GestureDetector(
                              onTap: () {
                                context.pushNamed(
                                    AppRoute.completeProfileScreen.name);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                  left: 20.w,
                                  right: 20.w,
                                  top: 20.h,
                                  bottom: 20.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: AppColors.homeContainerBorderColor,
                                    width: 1.w,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.homeContainerBorderColor,
                                      blurRadius: 3.r,
                                      // spreadRadius: 10.r,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        context.pushNamed(AppRoute
                                            .completeProfileScreen.name);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Complete your profile',
                                            style: AppTextStyle.satoshiFontText(
                                              context,
                                              AppColors.headerTextColor1,
                                              14.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 14.sp,
                                            color: AppColors
                                                .notificationHeaderColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    YBox(5),
                                    Text(
                                      'Just a few more changes',
                                      style: AppTextStyle.satoshiFontText(
                                        context,
                                        AppColors.headerTextColor2,
                                        14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    YBox(5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LinearPercentIndicator(
                                          percent: percentage(
                                              (vm.asData?.value.data
                                                      .isPinProvided ==
                                                  true),
                                              (vm.asData?.value.data
                                                      .isAddressComplete ==
                                                  true),
                                              (vm.asData?.value.data
                                                      .isCardProvided ==
                                                  true)),
                                          // percent: 0.3,
                                          width: 250.w,
                                          lineHeight: 13.0,
                                          barRadius: Radius.circular(4.r),
                                          progressColor:
                                              AppColors.primaryColor2,
                                          backgroundColor: AppColors
                                              .notificationReadCardColor,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0.0),
                                        ),
                                        Text(
                                          percentageText(
                                              (vm.asData?.value.data
                                                      .isPinProvided ==
                                                  true),
                                              (vm.asData?.value.data
                                                      .isAddressComplete ==
                                                  true),
                                              (vm.asData?.value.data
                                                      .isCardProvided ==
                                                  true)),
                                          style: AppTextStyle.satoshiFontText(
                                            context,
                                            AppColors.primaryTextColor,
                                            14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      (vm.asData?.value.data.isProfileComplete == true) &&
                              (vm.asData?.value.data.isAddressComplete ==
                                  true) &&
                              (vm.asData?.value.data.isCardProvided == true)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HomeQuickActionWidget(
                                  imgUrl: AppIcon.createTicketIcon,
                                  title: 'Create Ticket',
                                  subTitle:
                                      'Create a new ticket and let’s find you a pair',
                                  buttonText: 'New Ticket',
                                  onTap: () {
                                    showModalBottomSheet(
                                      // backgroundColor: Colors.transparent,
                                      barrierColor: AppColors.primaryColor
                                          .withOpacity(0.7),
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
                                ),
                                YBox(20),
                                HomeQuickActionWidget(
                                  imgUrl: AppIcon.homeTicketIcon,
                                  title: 'View Tickets',
                                  subTitle:
                                      'See all tickets and their progress',
                                  buttonText: 'View Ticket',
                                  onTap: widget.switchToTicketFn!,
                                ),
                                // YBox(20),
                                // HomeQuickActionWidget(
                                //   imgUrl: AppIcon.pendingVerificationIcon,
                                //   title: 'Pending Verification',
                                //   subTitle:
                                //       'We are reviewing your application. Please check back in 24 hours.',
                                //   buttonText: '',
                                //   onTap: () {},
                                //   showButton: false,
                                // ),
                              ],
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

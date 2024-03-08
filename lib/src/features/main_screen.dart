// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:repore/lib.dart';
// import 'package:repore/src/components/utils/bottomNav/persistent_tab_view.dart';
// import 'package:repore/src/components/utils/bottomNav/route_state.dart';

// //  type: "644c12f5eeeb723cac3cef45",
// // flutter: ║                 subject: "Test for notification",
// // flutter: ║                 author: "64ac82376a1c1ab5292c4b13",
// // flutter: ║                 customer: "64ac82376a1c1ab5292c4b13",
// // flutter: ║                 status: "Pending",
// // flutter: ║                 _id: "65018c40b6f6d3a78ebd3191",

// // 65018c40b6f6d3a78ebd3196

// class MainScreen extends ConsumerStatefulWidget {
//   final BuildContext menuScreenContext;
//   const MainScreen({required this.menuScreenContext, super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
// }

// class _MainScreenState extends ConsumerState<MainScreen> {
//   // late PersistentTabController controller;
//   late bool _hideNavBar;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       ref.read(routeStateProvider.notifier);
//     });
//     // controller = PersistentTabController(initialIndex: 0);
//     _hideNavBar = false;
//   }

//   List<Widget> _buildScreens() {
//     return [
//       HomeScreen(
//           // menuScreenContext: widget.menuScreenContext,
//           // hideStatus: _hideNavBar,
//           // onScreenHideButtonPressed: () {},
//           ),
//       TicketScreen(
//           // menuScreenContext: widget.menuScreenContext,
//           // hideStatus: _hideNavBar,
//           // onScreenHideButtonPressed: () {},
//           ),
//       NotificationScreen(
//           // menuScreenContext: widget.menuScreenContext,
//           // hideStatus: _hideNavBar,
//           // onScreenHideButtonPressed: () {},
//           ),
//       ProfileScreen(
//           // menuScreenContext: widget.menuScreenContext,
//           // hideStatus: _hideNavBar,
//           // onScreenHideButtonPressed: () {},
//           )
//     ];
//   }

//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: Image.asset(
//           AppIcon.homeActiveIcon,
//         ),
//         inactiveIcon: Image.asset(
//           AppIcon.homeIcon,
//         ),
//         title: "Home",
//         // textStyle: AppTextStyle.bodyText(
//         //   context,
//         //   AppColors.primaryTextColor2,
//         //   12.sp,
//         //   fontWeight: FontWeight.w500,
//         // ),
//         activeColorPrimary: AppColors.primaryTextColor2,
//         inactiveColorPrimary: AppColors.primaryTextColor2,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Image.asset(
//           AppIcon.ticketActiveIcon,
//         ),
//         inactiveIcon: Image.asset(
//           AppIcon.ticketIcon,
//         ),
//         title: "Ticket",
//         // textStyle: AppTextStyle.bodyText(
//         //   context,
//         //   AppColors.primaryTextColor2,
//         //   12.sp,
//         //   fontWeight: FontWeight.w500,
//         // ),
//         activeColorPrimary: AppColors.primaryTextColor2,
//         inactiveColorPrimary: AppColors.primaryTextColor2,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Image.asset(
//           AppIcon.notificationActiveIcon,
//         ),
//         inactiveIcon: Image.asset(
//           AppIcon.notificationIcon,
//         ),
//         //TODO: Notification text is smaller that other
//         //TODO: Also check doc to see why david is doinh ("")
//         title: "Notification",
//         // textStyle: AppTextStyle.bodyText(
//         //   context,
//         //   AppColors.primaryTextColor2,
//         //   14.sp,
//         //   fontWeight: FontWeight.w500,
//         // ),
//         activeColorPrimary: AppColors.primaryTextColor2,
//         inactiveColorPrimary: AppColors.primaryTextColor2,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Image.asset(
//           AppIcon.profileActiveIcon,
//         ),
//         inactiveIcon: Image.asset(
//           AppIcon.profileIcon,
//         ),
//         title: "Profile",
//         // textStyle: AppTextStyle.bodyText(
//         //   context,
//         //   AppColors.primaryTextColor2,
//         //   12.sp,
//         //   fontWeight: FontWeight.w500,
//         // ),
//         activeColorPrimary: AppColors.primaryTextColor2,
//         inactiveColorPrimary: AppColors.primaryTextColor2,
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controller = ref.watch(routeStateProvider);
//     return Scaffold(
//       body: PersistentTabView(
//         context,
//         controller: controller,
//         screens: _buildScreens(),
//         items: _navBarsItems(),
//         confineInSafeArea: true,
//         backgroundColor: Colors.white,
//         handleAndroidBackButtonPress: true,
//         resizeToAvoidBottomInset: true,
//         stateManagement: false,
//         navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
//             ? 0.0
//             : kBottomNavigationBarHeight,
//         hideNavigationBarWhenKeyboardShows: true,
//         margin: const EdgeInsets.all(0.0),
//         popActionScreens: PopActionScreensType.all,
//         bottomScreenMargin: 0.0,
//         onItemSelected: (value) {
//           controller.index = value;
//         },
//         selectedTabScreenContext: (context) {
//           // testContext = context;
//         },
//         hideNavigationBar: _hideNavBar,
//         decoration: const NavBarDecoration(
//           colorBehindNavBar: Colors.white,
//         ),
//         popAllScreensOnTapOfSelectedTab: true,
//         itemAnimationProperties: const ItemAnimationProperties(
//           duration: Duration(milliseconds: 400),
//           curve: Curves.ease,
//         ),
//         screenTransitionAnimation: const ScreenTransitionAnimation(
//           animateTabTransition: false,
//           curve: Curves.ease,
//           duration: Duration(milliseconds: 200),
//         ),
//         //TODO: chnage and customize the navbarstykle
//         navBarStyle: NavBarStyle.style3,
//       ),
//     );
//   }
// }

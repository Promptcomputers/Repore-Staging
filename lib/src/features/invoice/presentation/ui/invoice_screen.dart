import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:repore/lib.dart';

class InvoiceScreen extends ConsumerStatefulWidget {
  final String ticketId;
  const InvoiceScreen({required this.ticketId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends ConsumerState<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(getAallInvoiceTicketProvider(widget.ticketId));
    return Scaffold(
      backgroundColor: AppColors.primarybgColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Image.asset(
            AppIcon.backArrowIcon2,
          ),
        ),
        title: Text(
          'Invoices',
          style: AppTextStyle.josefinSansFont(
            context,
            AppColors.homeContainerBorderColor,
            20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
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
        child: vm.when(
          error: (error, stackTrace) => const SizedBox(),
          loading: () => const AppCircularLoading(),
          data: (value) {
            return value.data.isEmpty
                ? const Center(
                    child: EmptyNotificationStateWidget(
                      message: 'No Invoice yet',
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.only(
                        top: 20.h, left: 20.w, right: 20.w, bottom: 20.h),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => YBox(20),
                    itemCount: value.data.length,
                    itemBuilder: (context, index) {
                      final item = value.data[index];
                      //TODO: handle the suffix th, nd st
                      String formattedDate =
                          DateFormat("dd MMM, yyyy").format(item.createdAt);
                      // String formattedOrdinalDate =
                      //     DateFormat("dd'th' MMM, yyyy")
                      //         .format(item.createdAt);
                      return GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            AppRoute.invoicePreviewScreen.name,
                            queryParams: {
                              'invoiceId': item.id,
                              'invoiceRef': item.invoiceReference,
                              'subject': item.title,
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              width: 1.w,
                              color: AppColors.homeContainerBorderColor,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    item.invoiceType == "SERVICE"
                                        ? AppIcon.invoiceServiceIcon
                                        : AppIcon.invoiceAcquistionIcon,
                                    width: 30.w,
                                    height: 30.h,
                                  ),
                                  XBox(10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //TODO: Change to invoice name and check if the invoice name is coming from BE
                                      SizedBox(
                                        width: 180.w,
                                        child: Text(
                                          capitalizeFirstLetter(item.title),
                                          style: AppTextStyle.satoshiFontText(
                                            context,
                                            AppColors.primaryTextColor,
                                            14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      YBox(3),
                                      Text(
                                        formattedDate,
                                        style: AppTextStyle.satoshiFontText(
                                          context,
                                          AppColors.headerTextColor1,
                                          10.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    formatCurrency('${item.total}'),
                                    style: AppTextStyle.satoshiFontText(
                                      context,
                                      AppColors.primaryTextColor,
                                      14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  YBox(3),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 3.r,
                                        backgroundColor: invoiceStatusColor(
                                            item.approvalStatus),
                                      ),
                                      XBox(2),
                                      Text(
                                        //TODO: Changed to paid or pending, check from BE if paid is coming
                                        statusText(item.approvalStatus),
                                        style: AppTextStyle.satoshiFontText(
                                          context,
                                          invoiceStatusColor(
                                              item.approvalStatus),
                                          10.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}

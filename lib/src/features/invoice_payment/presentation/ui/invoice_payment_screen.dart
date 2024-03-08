import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

class InvoicePaymentScreen extends ConsumerStatefulWidget {
  final String amount;
  final String invoiceId;
  final String dueDate;
  const InvoicePaymentScreen({
    super.key,
    required this.amount,
    required this.dueDate,
    required this.invoiceId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InvoicePaymentScreenState();
}

enum RoleEnum { employer, professional, none }

class _InvoicePaymentScreenState extends ConsumerState<InvoicePaymentScreen> {
  int selectedIdx = 0; // Index of the selected item

  String cardId = '';
  @override
  Widget build(BuildContext context) {
    final getCardVm = ref.watch(getCardsProvider);

    ///TODO: HACK Find a better solution, it take the first cardId when selected else when ontap it take the slected item id
    cardId = selectedIdx == 0
        ? getCardVm.asData?.asData!.value.first.id ?? ''
        : cardId;

    return LoadingSpinner(
      child: Scaffold(
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
            'Payment',
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
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 18.w, right: 20.w, top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatCurrency(widget.amount),
                    style: AppTextStyle.satoshiFontText(
                      context,
                      AppColors.primaryTextColor,
                      20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  YBox(5),
                  Text(
                    'Due on: ${widget.dueDate}',
                    style: AppTextStyle.satoshiFontText(
                      context,
                      AppColors.headerTextColor1,
                      14.sp,
                    ),
                  ),
                  YBox(40),
                  getCardVm.when(
                    error: (error, stackTrace) => const SizedBox(),
                    loading: () => const AppCircularLoading(),
                    data: (value) {
                      return ListView.separated(
                        itemCount: value.length,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => YBox(20.h),
                        itemBuilder: (context, index) {
                          final item = value[index];
                          return GestureDetector(
                            ///TODO: Look for a better to handle when anywhere is taped
                            // onTap: () {
                            //   setState(() {
                            //     cardId = item.id;
                            //   });
                            //   // _handleChange(RoleEnum.employer);
                            // },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10.w,
                                  right: 10.w,
                                  top: 15.h,
                                  bottom: 15.h),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  width: 1.w,
                                  color: AppColors.homeContainerBorderColor,
                                ),
                              ),
                              child: ListTile(
                                leading: Transform.translate(
                                  offset: const Offset(-20, -6),
                                  child: Radio(
                                    activeColor: AppColors.buttonBgColor2,
                                    focusColor: AppColors.redColor,
                                    value: index,
                                    groupValue: selectedIdx,
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedIdx = value!;
                                        cardId = item.id;
                                      });
                                      Console.print(
                                          'selected cardid in onchanged $cardId');
                                    },
                                  ),
                                ),
                                title: Transform.translate(
                                  offset: const Offset(-25, 0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ///TODO:
                                      ///Use item.type to display the logo
                                      Image.asset(AppIcon.masterCardLogo),
                                      XBox(20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${capitalizeFirstLetter(item.type)} .... ${item.lastDigits}',
                                            style: AppTextStyle.satoshiFontText(
                                              context,
                                              AppColors.headerTextColor1,
                                              14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            'Expires: ${item.expireDate}',
                                            style: AppTextStyle.satoshiFontText(
                                              context,
                                              AppColors.headerTextColor1,
                                              12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Visibility(
                    visible: !getCardVm.isLoading,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          barrierColor:
                              AppColors.primaryTextColor.withOpacity(1.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.0.sp),
                            ),
                          ),
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => const AddCardBottomSheet(),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.buttonBgColor2,
                            size: 14.sp,
                          ),
                          Text(
                            'Bill other card',
                            // 'Add new card',
                            style: AppTextStyle.satoshiFontText(
                              context,
                              AppColors.buttonBgColor2,
                              14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !getCardVm.isLoading,
              child: Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, bottom: 30.h, top: 15.h),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border.all(
                      color: AppColors.homeContainerBorderColor,
                    ),
                  ),
                  child: AppButton(
                    buttonText: 'Make payment',
                    bgColor: AppColors.buttonBgColor2,
                    borderColor: AppColors.buttonBgColor2,
                    onPressed: () {
                      showModalBottomSheet(
                        // backgroundColor: Colors.transparent,
                        barrierColor:
                            AppColors.primaryTextColor.withOpacity(1.0),
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.vertical(
                        //     top: Radius.circular(20.0.sp),
                        //   ),
                        // ),
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => EnterPinWidget(
                          invoiceId: widget.invoiceId,
                          cardId: cardId,
                          status: true,
                          reason: '',
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:repore/lib.dart';

class EnterPinWidget extends ConsumerStatefulWidget {
  final String invoiceId;
  final String cardId;
  final bool status;

  ///true == accept, false, reject
  final String reason;
  const EnterPinWidget(
      {required this.cardId,
      required this.invoiceId,
      required this.status,
      required this.reason,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnterPinWidgetState();
}

class _EnterPinWidgetState extends ConsumerState<EnterPinWidget> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  String otpCode = '';
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(updateInvoiceStatus);
    ref.listen<AsyncValue>(updateInvoiceStatus, (T, value) {
      if (value.hasValue) {
        ref.invalidate(viewInvoiceProvider(widget.invoiceId));
        ref.invalidate(getAallInvoiceTicketProvider(widget.invoiceId));
        // context.loaderOverlay.hide();
        context.pop();

        context.pushNamed(
          AppRoute.invoicePaymentSuccessScreen.name,
        );
      }
      if (value.hasError) {
        // context.loaderOverlay.hide();
        context.pop();
        showErrorToast(context, value.error.toString());
        // showErrorToast(context, "an error occurred, try again");
      }
    });
    return Form(
      key: formKey,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color: AppColors.whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 40.h, bottom: 50.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Text(
                          'Enter pin',
                          style: AppTextStyle.josefinSansFont(
                            context,
                            AppColors.primaryTextColor,
                            24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Icon(
                            Icons.close,
                            color: AppColors.headerTextColor1,
                            size: 20.sp,
                          ),
                        )
                      ],
                    ),
                    YBox(20),
                    Padding(
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: PinCodeTextField(
                        errorTextSpace: 32.sp,

                        enableActiveFill: true,
                        // backgroundColor: AppColors.secondaryColor3,
                        obscureText: true,
                        appContext: context,
                        controller: otpController,
                        length: 4,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter pin';
                          }
                          return null;
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          inactiveColor: AppColors.textFormFieldBorderColor,
                          activeColor: AppColors.textFormFieldBorderColor,
                          selectedColor: AppColors.textFormFieldBorderColor,
                          selectedFillColor: AppColors.textFormFieldBorderColor,
                          borderRadius: BorderRadius.circular(8.r),
                          fieldHeight: 50.h,
                          fieldWidth: 50.w,
                          activeFillColor: AppColors.textFormFieldBorderColor,
                          inactiveFillColor: AppColors.textFormFieldBorderColor,
                          fieldOuterPadding: const EdgeInsets.all(3),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          // print(value);
                          // pinValue = value;
                          // print(pinValue);
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),
                    ),
                    YBox(40),
                    AppButton(
                      buttonText: 'Continue',
                      isLoading: vm.isLoading,
                      bgColor: AppColors.buttonBgColor2,
                      borderColor: AppColors.buttonBgColor2,
                      onPressed: () {
                        //   ref
                        // .read(updateInvoiceStatus.notifier)
                        // .updateInvoiceStatus(
                        //     widget.invoiceId, 'REJECT', reason, '');
                        ref
                            .read(updateInvoiceStatus.notifier)
                            .updateInvoiceStatus(
                                widget.invoiceId,
                                widget.status == true ? 'ACCEPT' : 'REJECT',
                                widget.status == true ? '' : widget.reason,
                                widget.status == true ? widget.cardId : '',
                                otpController.text.trim());
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

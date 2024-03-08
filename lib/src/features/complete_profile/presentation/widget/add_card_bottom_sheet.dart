import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repore/lib.dart';

class AddCardBottomSheet extends ConsumerStatefulWidget {
  const AddCardBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends ConsumerState<AddCardBottomSheet> {
  String secretClientKey = '';
  CardFieldInputDetails? _card;

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(stripeProvider, (T, value) async {
      if (value.hasValue) {
        secretClientKey = value.value['data']['client_secret'];

        ref
            .read(confirmSetupIntentProvider.notifier)
            .handleSavePress(context, secretClientKey)
            .then((value) {
          if (value == true) {
            ///TODO: Find a solution to detect if they are adding from complete profile or from payment method
            log('setp intent confirmed');
            context.loaderOverlay.hide();
            ref.invalidate(getCardsProvider);
            context.pop();
            //TODO: Might remove because of from payment methid
            context.pop();

            ref.invalidate(getUserDetailsProvider);
            // PreferenceManager.hasCardAdded == true;

            showSuccessToast(context, 'Card Added Successfully');
          } else {
            showErrorToast(context, "An error occured, try again later");
            context.loaderOverlay.hide();
          }
        });
      }
      if (value.hasError) {
        showErrorToast(context, "An error occured, try again later");
        context.loaderOverlay.hide();
      }
    });

    final confirmSetupVM = ref.watch(confirmSetupIntentProvider);
    final stripeVm = ref.watch(stripeProvider);
    return LoadingSpinner(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, top: 40.h, bottom: 50.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Card',
                        style: AppTextStyle.satoshiFontText(
                          context,
                          AppColors.headerTextColor2,
                          20.sp,
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
                  YBox(30.h),
                  CardField(
                    onCardChanged: (card) {
                      setState(() {
                        _card = card;
                      });
                    },
                  ),
                  YBox(20.h),
                  AppDivider(0),
                  YBox(20.h),
                  AppButton(
                    buttonText: 'Done',
                    isLoading: stripeVm.isLoading && confirmSetupVM.isLoading,
                    onPressed: (stripeVm.isLoading || confirmSetupVM.isLoading)
                        ? null
                        : () {
                            _card?.complete == true
                                ? ref
                                    .read(stripeProvider.notifier)
                                    .createSetupIntentFromDb()
                                : null;
                            log('card details $_card');
                            // context.pop();
                            context.loaderOverlay.show();
                          },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

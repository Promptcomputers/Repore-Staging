import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repore/lib.dart';

class EditProfileTabView extends ConsumerStatefulWidget {
  const EditProfileTabView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileTabViewState();
}

class _EditProfileTabViewState extends ConsumerState<EditProfileTabView> {
  // String id = '';
  final formKey = GlobalKey<FormState>();
  // final companyController = TextEditingController();
  final companyFocusNode = FocusNode();
  // final phoneNoController = TextEditingController();
  final phoneNoFocusNode = FocusNode();
  // final addressController = TextEditingController();
  final addressFocusNode = FocusNode();
  // final stateController = TextEditingController();
  final stateFocusNode = FocusNode();
  // final cityController = TextEditingController();
  final cityFocusNode = FocusNode();
  final zipCodeController = TextEditingController();
  final zipCodeFocusNode = FocusNode();

  @override
  void dispose() {
    // companyController.dispose();
    // phoneNoController.dispose();
    // addressController.dispose();
    // stateController.dispose();
    // cityController.dispose();
    // zipCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userVm = ref.watch(getUserDetailsProvider);

    final companyController = TextEditingController();
    // final companyController =
    //     TextEditingController(text: userVm.asData!.value.data!.company);
    // final phoneNoController = TextEditingController(
    //     text: userVm.asData!.value.data!.phone.toString());
    final addressController = TextEditingController();
    // final addressController =
    //     TextEditingController(text: userVm.asData!.value.data!.address);
    final stateController = TextEditingController();
    // final stateController =
    //     TextEditingController(text: userVm.asData!.value.data!.state);
    final cityController = TextEditingController();
    // final cityController =
    //     TextEditingController(text: userVm.asData!.value.data!.city);
    final zipCodeController = TextEditingController();
    // final zipCodeController =
    //     TextEditingController(text: userVm.asData!.value.data!.zipcode);

    ref.listen<AsyncValue>(updateProfileProvider, (T, value) {
      if (value.hasValue) {
        ref.invalidate(getUserDetailsProvider);
        showSuccessToast(context, 'Profile updated successful');
        context.loaderOverlay.hide();
        FocusManager.instance.primaryFocus?.unfocus();
      }
      if (value.hasError) {
        context.loaderOverlay.hide();
        showErrorToast(context, value.error.toString());
        FocusManager.instance.primaryFocus?.unfocus();
      }
    });

    return LoadingSpinner(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 100.h),
        decoration: const BoxDecoration(color: AppColors.whiteColor
            // color: AppColors.homeContainerBorderColor.withOpacity(0.2),
            ),
        child: Form(
          key: formKey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 56.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: AppColors.buttonBgColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      '${getStringFirstLetter(userVm.asData!.value.data.firstname.toUpperCase())}${getStringFirstLetter(userVm.asData!.value.data.lastname.toUpperCase())}',
                      // 'MD',
                      style: AppTextStyle.josefinSansFont(
                        context,
                        AppColors.buttonBgColor,
                        20.sp,
                      ),
                    ),
                  ),
                ),
              ),
              YBox(5),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '${capitalizeFirstLetter(userVm.asData!.value.data.firstname)} ${capitalizeFirstLetter(userVm.asData!.value.data.lastname)}',
                  style: AppTextStyle.satoshiFontText(
                    context,
                    AppColors.primaryTextColor,
                    16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              YBox(5),
              Align(
                alignment: Alignment.center,
                child: Text(
                  userVm.asData!.value.data.email,
                  style: AppTextStyle.satoshiFontText(
                    context,
                    AppColors.primaryTextColor,
                    14.sp,
                  ),
                ),
              ),
              YBox(20),
              const FormLabel(
                text: 'Company',
              ),
              YBox(6),
              AppTextField(
                controller: companyController,
                hintText: 'Axeon N',
                focusNode: companyFocusNode,
                keyboardType: TextInputType.name,
                validator: (value) => Validator.validateField(value,
                    errorMessage: 'Company name cannot be empty'),
                onFieldSubmitted: (value) {
                  if (FormStringUtils.isNotEmpty(value)) {
                    companyFocusNode.requestFocus();
                  }
                },
              ),
              // YBox(20.h),
              // const FormLabel(
              //   text: 'Phone number',
              // ),
              // YBox(6.h),
              // AppTextField(
              //   controller: phoneNoController,
              //   hintText: 'Axeon N',
              //   focusNode: phoneNoFocusNode,
              //   keyboardType: TextInputType.name,
              //   validator: (value) => Validator.validateField(value,
              //       errorMessage: 'Phone no cannot be empty'),
              //   onFieldSubmitted: (value) {
              //     if (FormStringUtils.isNotEmpty(value)) {
              //       phoneNoFocusNode.requestFocus();
              //     }
              //   },
              // ),
              YBox(20),
              const FormLabel(
                text: 'Address',
              ),
              YBox(6),
              AppTextField(
                controller: addressController,
                hintText: 'Axeon N',
                focusNode: addressFocusNode,
                keyboardType: TextInputType.name,
                validator: (value) => Validator.validateField(value,
                    errorMessage: 'Address cannot be empty'),
                onFieldSubmitted: (value) {
                  if (FormStringUtils.isNotEmpty(value)) {
                    addressFocusNode.requestFocus();
                  }
                },
              ),
              YBox(20),
              const FormLabel(
                text: 'State',
              ),
              YBox(6),
              AppTextField(
                controller: stateController,
                hintText: 'Massachusetts',
                focusNode: stateFocusNode,
                keyboardType: TextInputType.name,
                validator: (value) => Validator.validateField(value,
                    errorMessage: 'State cannot be empty'),
                onFieldSubmitted: (value) {
                  if (FormStringUtils.isNotEmpty(value)) {
                    stateFocusNode.requestFocus();
                  }
                },
              ),
              YBox(20),
              const FormLabel(
                text: 'City',
              ),
              YBox(6),
              AppTextField(
                controller: cityController,
                hintText: 'Columbus',
                focusNode: cityFocusNode,
                keyboardType: TextInputType.name,
                validator: (value) => Validator.validateField(value,
                    errorMessage: 'City cannot be empty'),
                onFieldSubmitted: (value) {
                  if (FormStringUtils.isNotEmpty(value)) {
                    cityFocusNode.requestFocus();
                  }
                },
              ),
              YBox(20),
              const FormLabel(
                text: 'Zipcode',
              ),
              YBox(6),
              AppTextField(
                controller: zipCodeController,
                hintText: '456435',
                focusNode: zipCodeFocusNode,
                keyboardType: TextInputType.name,
                validator: (value) => Validator.validateField(value,
                    errorMessage: 'Zip code cannot be empty'),
                onFieldSubmitted: (value) {
                  if (FormStringUtils.isNotEmpty(value)) {
                    zipCodeFocusNode.requestFocus();
                  }
                },
              ),
              YBox(50),
              AppButton(
                buttonText: 'Save chnages',
                onPressed: () {
                  final userId = PreferenceManager.userId;
                  var updateProfileReq = UpdateProfileReq(
                      company: companyController.text.trim(),
                      address: addressController.text.trim(),
                      city: cityController.text.trim(),
                      state: stateController.text.trim(),
                      zipcode: zipCodeController.text.trim());
                  ref
                      .read(updateProfileProvider.notifier)
                      .updateProfile(updateProfileReq, userId);
                  context.loaderOverlay.show();
                  // context.goNamed(
                  //   AppRoute.registerConfirm.name,
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
    // return BottomExpandedViewWidget(
    //   radius: 0.0,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: const [],
    //   ),
    // );
  }
}

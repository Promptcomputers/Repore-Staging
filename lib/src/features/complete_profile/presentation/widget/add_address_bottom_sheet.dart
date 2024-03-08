import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

class AddAdressBottomSheet extends ConsumerStatefulWidget {
  const AddAdressBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddAdressBottomSheetState();
}

class _AddAdressBottomSheetState extends ConsumerState<AddAdressBottomSheet> {
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();
  final addressFocusNode = FocusNode();
  final stateFocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  final zipCodeFocusNode = FocusNode();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  final List<String> item = ['male', 'female'];

  @override
  void dispose() {
    addressController.dispose();
    stateController.dispose();
    cityController.dispose();
    zipCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(updateProfileProvider, (T, value) {
      if (value.hasValue) {
        ref.invalidate(getUserDetailsProvider);
        showSuccessToast(context, 'Address added successful');
        context.pop();

        FocusManager.instance.primaryFocus?.unfocus();
      }
      if (value.hasError) {
        showErrorToast(context, value.error.toString());
        FocusManager.instance.primaryFocus?.unfocus();
      }
    });
    final vm = ref.watch(updateProfileProvider);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, top: 40.h, bottom: 60.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile info',
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
                  const FormLabel(
                    text: 'Address',
                  ),
                  YBox(6.h),
                  AppTextField(
                    controller: addressController,
                    hintText: 'Axeon N',
                    focusNode: addressFocusNode,
                    keyboardType: TextInputType.name,
                    validator: (value) => Validator.validateField(value,
                        errorMessage: 'Address cannot be empty'),
                    textInputAction: TextInputAction.next,
                    // onFieldSubmitted: (value) {
                    //   if (FormStringUtils.isNotEmpty(value)) {
                    //     addressFocusNode.requestFocus(stateFocusNode);
                    //   }
                    // },
                  ),
                  // YBox(20.h),
                  // const FormLabel(
                  //   text: 'State',
                  // ),
                  // YBox(6.h),
                  // AppTextField(
                  //   controller: stateController,
                  //   hintText: 'Massachusetts',
                  //   focusNode: stateFocusNode,
                  //   keyboardType: TextInputType.name,
                  //   validator: (value) => Validator.validateField(value,
                  //       errorMessage: 'State cannot be empty'),
                  //   textInputAction: TextInputAction.next,
                  //   // onFieldSubmitted: (value) {
                  //   //   if (FormStringUtils.isNotEmpty(value)) {
                  //   //     stateFocusNode.requestFocus(cityFocusNode);
                  //   //   }
                  //   // },
                  // ),
                  // YBox(20.h),
                  // const FormLabel(
                  //   text: 'City',
                  // ),
                  // YBox(6.h),
                  // AppTextField(
                  //   controller: cityController,
                  //   hintText: 'Columbus',
                  //   focusNode: cityFocusNode,
                  //   keyboardType: TextInputType.name,
                  //   validator: (value) => Validator.validateField(value,
                  //       errorMessage: 'City cannot be empty'),
                  //   textInputAction: TextInputAction.next,
                  //   // onFieldSubmitted: (value) {
                  //   //   if (FormStringUtils.isNotEmpty(value)) {
                  //   //     cityFocusNode.requestFocus(zipCodeFocusNode);
                  //   //   }
                  //   // },
                  // ),
                  // YBox(20.h),
                  // const FormLabel(
                  //   text: 'Zipcode',
                  // ),
                  // YBox(6.h),
                  // AppTextField(
                  //   controller: zipCodeController,
                  //   hintText: '456435',
                  //   focusNode: zipCodeFocusNode,
                  //   keyboardType: TextInputType.name,
                  //   validator: (value) => Validator.validateField(value,
                  //       errorMessage: 'Zip code cannot be empty'),
                  //   textInputAction: TextInputAction.done,
                  //   // onFieldSubmitted: (value) {
                  //   //   if (FormStringUtils.isNotEmpty(value)) {
                  //   //     zipCodeFocusNode.requestFocus(zipCodeFocusNode);
                  //   //   } else {
                  //   //     FocusManager.instance.primaryFocus?.unfocus();
                  //   //   }
                  //   // },
                  // ),
                  // YBox(20.h),
                  // AppDivider(0),
                  // YBox(20.h),

                  YBox(20.h),
                  const FormLabel(
                    text: 'Gender',
                  ),
                  YBox(6.h),
                  DropdownButtonFormField<String>(
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 28.sp,
                      color: AppColors.headerTextColor1,
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select gender';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Select",
                      hintStyle: AppTextStyle.satoshiFontText(
                        context,
                        AppColors.headerTextColor1,
                        14.sp,
                      ),
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(
                            color: AppColors.textFormFieldBorderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(
                            color: AppColors.textFormFieldBorderColor),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(color: AppColors.redColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(color: AppColors.redColor),
                      ),
                    ),
                    items: item.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(
                        () {
                          genderController.text = value!;
                        },
                      );
                    },
                  ),
                  YBox(20),
                  const FormLabel(
                    text: 'Date of Birth',
                  ),
                  YBox(6.h),

                  DateTimePicker(
                    dateMask: 'd/M/yyyy',
                    // autovalidate: true,
                    initialDate: DateTime(2000),
                    // firstDate: DateTime.now(),
                    // lastDate: DateTime.now(),
                    firstDate: DateTime(1976),
                    lastDate: DateTime(2000),
                    controller: dobController,
                    decoration: InputDecoration(
                      hintText: '00 - 00 - 0000',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(
                            color: AppColors.textFormFieldBorderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                            color: AppColors.textFormFieldBorderColor),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(color: AppColors.redColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(color: AppColors.redColor),
                      ),
                      labelStyle: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF86828D),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {});
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Due date is required';
                      }
                      return null;
                    },
                    onSaved: (val) => debugPrint(val),
                  ),
                  YBox(50),
                  AppButton(
                    buttonText: 'Done',
                    isLoading: vm.isLoading,
                    onPressed: vm.isLoading
                        ? null
                        : () {
                            final userId = PreferenceManager.userId;
                            var updateProfileReq = UpdateProfileReq(
                              // company: '',
                              address: addressController.text.trim(),
                              // city: cityController.text.trim(),
                              // state: stateController.text.trim(),
                              // zipcode: zipCodeController.text.trim(),
                              gender: genderController.text.trim(),
                              dateOfBirth: dobController.text.trim(),
                            );
                            ref
                                .read(updateProfileProvider.notifier)
                                .updateProfile(updateProfileReq, userId);
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

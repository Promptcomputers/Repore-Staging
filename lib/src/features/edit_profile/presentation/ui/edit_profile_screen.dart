import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

class EditProfileScreen extends StatefulHookConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  String id = '';
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
  final dobController = TextEditingController();
  final List<String> item = ['male', 'female'];

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
  void initState() {
    // setState(() {
    //   id = PreferenceManager.userId;
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userVm = ref.watch(getUserDetailsProvider);
    final updateProfileVM = ref.watch(updateProfileProvider);
    final phoneNoController =
        useTextEditingController(text: userVm.asData?.value.data.phone ?? '');
    final addressController =
        useTextEditingController(text: userVm.asData?.value.data.address ?? '');

    final genderController =
        useTextEditingController(text: userVm.asData?.value.data.gender ?? '');
    final dobController = useTextEditingController(
        text: userVm.asData?.value.data.dob.toString() ?? '');
    // dobController.text = userVm.asData?.value.data.dob.toString() ?? '';

    ref.listen<AsyncValue>(updateProfileProvider, (T, value) {
      if (value.hasValue) {
        ref.invalidate(getUserDetailsProvider);
        showSuccessToast(context, 'Profile updated successfully');
        // context.loaderOverlay.hide();
        FocusManager.instance.primaryFocus?.unfocus();
      }
      if (value.hasError) {
        // context.loaderOverlay.hide();
        showErrorToast(context, value.error.toString());
        FocusManager.instance.primaryFocus?.unfocus();
      }
    });

    ///I removed loading spinner because loading overlay was not showing
    ///Also isLoading not working on button
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
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
            'Edit Profile',
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
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const FormLabel(
                    //   text: 'Company',
                    // ),
                    // YBox(6.h),
                    // AppTextField(
                    //   controller: companyController,
                    //   hintText: 'Axeon N',
                    //   focusNode: companyFocusNode,
                    //   keyboardType: TextInputType.name,
                    //   validator: (value) => Validator.validateField(value,
                    //       errorMessage: 'Company name cannot be empty'),
                    //   onFieldSubmitted: (value) {
                    //     if (FormStringUtils.isNotEmpty(value)) {
                    //       companyFocusNode.requestFocus();
                    //     }
                    //   },
                    // ),
                    const FormLabel(
                      text: 'Phone number',
                    ),
                    YBox(6),
                    AppTextField(
                      controller: phoneNoController,
                      hintText: '+41 7237 3840',
                      focusNode: phoneNoFocusNode,
                      keyboardType: TextInputType.phone,
                      validator: (value) => Validator.validateField(value,
                          errorMessage: "Phone number can't be empty"),
                      onFieldSubmitted: (value) {
                        if (FormStringUtils.isNotEmpty(value)) {
                          addressFocusNode.requestFocus();
                        }
                      },
                    ),

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
                    //   onFieldSubmitted: (value) {
                    //     if (FormStringUtils.isNotEmpty(value)) {
                    //       stateFocusNode.requestFocus();
                    //     }
                    //   },
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
                    //   onFieldSubmitted: (value) {
                    //     if (FormStringUtils.isNotEmpty(value)) {
                    //       cityFocusNode.requestFocus();
                    //     }
                    //   },
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
                    //   onFieldSubmitted: (value) {
                    //     if (FormStringUtils.isNotEmpty(value)) {
                    //       zipCodeFocusNode.requestFocus();
                    //     }
                    //   },
                    // ),
                    // YBox(50.h),
                    YBox(20),
                    const FormLabel(
                      text: 'Gender',
                    ),
                    YBox(6),
                    DropdownButtonFormField<String>(
                      value: genderController.text.isEmpty
                          ? null
                          : genderController.text,
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
                          borderSide:
                              const BorderSide(color: AppColors.redColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide:
                              const BorderSide(color: AppColors.redColor),
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
                    YBox(6),

                    DateTimePicker(
                      dateMask: 'd/M/yyyy',
                      // autovalidate: true,
                      initialDate: DateTime(2008),
                      // firstDate: DateTime.now(),
                      // lastDate: DateTime.now(),
                      firstDate: DateTime(1959),
                      lastDate: DateTime(2008),
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
                          borderSide:
                              const BorderSide(color: AppColors.redColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide:
                              const BorderSide(color: AppColors.redColor),
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
                          return 'Date of birth is required';
                        }
                        return null;
                      },
                      onSaved: (val) => Console.print(val),
                    ),
                  ],
                ),
                AppButton(
                  buttonText: 'Save changes',
                  isLoading: updateProfileVM.isLoading,
                  onPressed: updateProfileVM.isLoading
                      ? null
                      : () {
                          final userId = PreferenceManager.userId;
                          var updateProfileReq = UpdateProfileReq(
                              phoneNo: phoneNoController.text.trim(),
                              address: addressController.text.trim(),
                              gender: genderController.text.trim(),
                              dateOfBirth: dobController.text.trim()
                              // company: companyController.text.trim(),
                              // address: addressController.text.trim(),
                              // city: cityController.text.trim(),
                              // state: stateController.text.trim(),
                              // zipcode: zipCodeController.text.trim(),
                              );
                          ref
                              .read(updateProfileProvider.notifier)
                              .updateProfile(updateProfileReq, userId);
                          // context.loaderOverlay.show();

                          // context.goNamed(
                          //   AppRoute.registerConfirm.name,
                          // );
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

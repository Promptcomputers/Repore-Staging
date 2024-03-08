import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repore/lib.dart';

class ChangePasswordTabView extends ConsumerStatefulWidget {
  const ChangePasswordTabView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordTabViewState();
}

class _ChangePasswordTabViewState extends ConsumerState<ChangePasswordTabView> {
  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final oldPasswordFocusNode = FocusNode();
  final newPasswordController = TextEditingController();
  final newPasswordFocusNode = FocusNode();
  final confirmNewPasswordController = TextEditingController();
  final confirmNewPasswordFocusNode = FocusNode();
  bool password = false;
  bool confirmPassword = false;
  bool confirmNewPassword = false;

  @override
  void dispose() {
    // oldPasswordController.dispose();
    // newPasswordController.dispose();
    // confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(changePasswordProvider, (T, value) {
      if (value.hasValue) {
        showSuccessToast(context, 'Password changed successful');

        // oldPasswordController.clear();
        // newPasswordController.clear();
        // confirmNewPasswordController.clear();
        context.loaderOverlay.hide();
      }
      if (value.hasError) {
        context.loaderOverlay.hide();
        showErrorToast(context, value.error.toString());
      }
    });
    return LoadingSpinner(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
        decoration: const BoxDecoration(color: AppColors.whiteColor
            // color: AppColors.homeContainerBorderColor.withOpacity(0.2),
            ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FormLabel(
                text: 'Old Password',
              ),
              YBox(6),
              AppTextField(
                hintText: '*******',
                controller: oldPasswordController,
                obscureText: password ? false : true,
                focusNode: oldPasswordFocusNode,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) => Validator.validatePassword(value),
                onFieldSubmitted: (value) {
                  if (FormStringUtils.isNotEmpty(value)) {
                    oldPasswordFocusNode.requestFocus();
                  }
                },
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      password = !password;
                    });
                  },
                  child: Icon(
                    password ? Icons.visibility_off : Icons.visibility_sharp,
                    color: AppColors.headerTextColor1,
                  ),
                ),
              ),
              YBox(20),
              const FormLabel(
                text: 'New Password',
              ),
              YBox(6),
              AppTextField(
                hintText: '*******',
                controller: newPasswordController,
                obscureText: confirmPassword ? false : true,
                focusNode: newPasswordFocusNode,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) => Validator.validatePassword(value),
                onFieldSubmitted: (value) {
                  if (FormStringUtils.isNotEmpty(value)) {
                    newPasswordFocusNode.requestFocus();
                  }
                },
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      confirmPassword = !confirmPassword;
                    });
                  },
                  child: Icon(
                    confirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility_sharp,
                    color: AppColors.headerTextColor1,
                  ),
                ),
              ),
              YBox(20),
              const FormLabel(
                text: 'Re-enter Password',
              ),
              YBox(6),
              AppTextField(
                hintText: '*******',
                controller: confirmNewPasswordController,
                obscureText: confirmNewPassword ? false : true,
                focusNode: confirmNewPasswordFocusNode,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) => Validator.validateConfirmPassword(
                    value, newPasswordController.text),
                onFieldSubmitted: (value) {
                  if (FormStringUtils.isNotEmpty(value)) {
                    confirmNewPasswordFocusNode.requestFocus();
                  }
                },
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      confirmNewPassword = !confirmNewPassword;
                    });
                  },
                  child: Icon(
                    confirmNewPassword
                        ? Icons.visibility_off
                        : Icons.visibility_sharp,
                    color: AppColors.headerTextColor1,
                  ),
                ),
              ),
              YBox(50),
              AppButton(
                buttonText: 'Save changes',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final userId = PreferenceManager.userId;
                    ref.read(changePasswordProvider.notifier).changePassword(
                          oldPasswordController.text.trim(),
                          newPasswordController.text.trim(),
                          userId,
                        );
                    context.loaderOverlay.show();
                  }
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

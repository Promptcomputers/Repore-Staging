import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repore/lib.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final firstNameFocusNode = FocusNode();
  final lastNameController = TextEditingController();
  final lastNameFocusNode = FocusNode();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  final phoneNoController = TextEditingController();
  final phoneNoFocusNode = FocusNode();
  final companyNameController = TextEditingController();
  final companyNameFocusNode = FocusNode();
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final confirmPasswordController = TextEditingController();
  final confirmPasswordFocusNode = FocusNode();
  bool isTermToggle = false;
  bool password = false;
  bool confirmPassword = false;
  String code = "+234";
  bool isFirstNameFilled = false;
  String firstNameErrorText = "";
  bool isLastNameFilled = false;
  String lastNameErrorText = "";
  bool isEmailFilled = false;
  String emailErrorText = "";
  bool isPasswordFilled = false;
  String passwordErrorText = "";

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    number = number;
  }

  PhoneNumber number = PhoneNumber(isoCode: 'US');

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNoController.dispose();
    companyNameController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(registerProvider, (T, value) {
      if (value.hasValue) {
        context.pushReplacementNamed(
          AppRoute.login.name,
        );
        showSuccessToast(context, 'Registration successful');
        context.loaderOverlay.hide();
      }
      if (value.hasError) {
        context.loaderOverlay.hide();
        showErrorToast(context, value.error.toString());
      }
    });
    return LoadingSpinner(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.whiteColor,
            elevation: 0.0,
            toolbarHeight: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppColors.whiteColor, // <-- SEE HERE
              statusBarIconBrightness:
                  Brightness.dark, //<-- For Android SEE HERE (dark icons)
              statusBarBrightness:
                  Brightness.light, //<-- For iOS SEE HERE (dark icons)
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, top: 30.h, bottom: 30.h),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(AppIcon.logoMark),
                    YBox(10),
                    Text(
                      'Sign Up',
                      style: AppTextStyle.josefinSansFont(
                        context,
                        AppColors.primaryTextColor,
                        24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    YBox(10),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: AppTextStyle.satoshiFontText(
                          context,
                          AppColors.headerTextColor1,
                          14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.pushReplacementNamed(
                                  AppRoute.login.name,
                                );
                              },
                            text: 'Log in',
                            style: AppTextStyle.satoshiFontText(
                              context,
                              AppColors.buttonBgColor,
                              14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    YBox(20),
                    const FormLabel(
                      text: 'First name',
                    ),
                    YBox(6),
                    AppTextField(
                      controller: firstNameController,
                      hintText: 'Isreal',
                      focusNode: firstNameFocusNode,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      // validator: (value) => Validator.validateField(value,
                      //     errorMessage: 'First name cannot be empty'),
                      enabledBorderColor: isFirstNameFilled == true
                          ? AppColors.redColor
                          : AppColors.textFormFieldBorderColor,
                      onChanged: (String value) {
                        setState(() {
                          isFirstNameFilled = false;
                          firstNameErrorText = '';
                        });
                      },

                      // onFieldSubmitted: (value) {
                      //   if (FormStringUtils.isNotEmpty(value)) {
                      //     firstNameFocusNode.requestFocus(lastNameFocusNode);
                      //   }
                      // },
                    ),
                    YBox(3),
                    isFirstNameFilled == true
                        ? Text(
                            firstNameErrorText,
                            style: AppTextStyle.satoshiFontText(
                              context,
                              AppColors.redColor,
                              14.sp,
                            ),
                          )
                        : const SizedBox(),
                    YBox(10),
                    const FormLabel(
                      text: 'Last name',
                    ),
                    YBox(6),
                    AppTextField(
                      controller: lastNameController,
                      hintText: 'Bamidele',
                      focusNode: lastNameFocusNode,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      // validator: (value) => Validator.validateField(value,
                      //     errorMessage: 'Last name cannot be empty'),
                      enabledBorderColor: isLastNameFilled == true
                          ? AppColors.redColor
                          : AppColors.textFormFieldBorderColor,
                      onChanged: (String value) {
                        setState(() {
                          isLastNameFilled = false;
                          lastNameErrorText = '';
                        });
                      },
                      // onFieldSubmitted: (value) {
                      //   if (FormStringUtils.isNotEmpty(value)) {
                      //     lastNameFocusNode.requestFocus(emailFocusNode);
                      //   }
                      // },
                    ),
                    YBox(3),
                    isLastNameFilled == true
                        ? Text(
                            lastNameErrorText,
                            style: AppTextStyle.satoshiFontText(
                              context,
                              AppColors.redColor,
                              14.sp,
                            ),
                          )
                        : const SizedBox(),
                    YBox(10),
                    const FormLabel(
                      text: 'Email',
                    ),
                    YBox(6),
                    AppTextField(
                      controller: emailController,
                      hintText: 'isreaelbamidele@gmail.com',
                      focusNode: emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      // validator: (value) => Validator.validateEmail(value),
                      enabledBorderColor: isEmailFilled == true
                          ? AppColors.redColor
                          : AppColors.textFormFieldBorderColor,
                      onChanged: (String? value) {
                        if (!RegExp(
                                "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                            .hasMatch(value!)) {
                          // return 'Please input a valid email address';
                          setState(() {
                            isEmailFilled = true;
                            emailErrorText =
                                'Please input a valid email address';
                          });
                        } else {
                          setState(() {
                            isEmailFilled = false;
                          });
                        }
                      },
                      // onFieldSubmitted: (value) {
                      //   if (FormStringUtils.isNotEmpty(value)) {
                      //     emailFocusNode.requestFocus(phoneNoFocusNode);
                      //   }
                      // },
                    ),
                    YBox(3),
                    isEmailFilled == true
                        ? Text(
                            emailErrorText,
                            style: AppTextStyle.satoshiFontText(
                              context,
                              AppColors.redColor,
                              14.sp,
                            ),
                          )
                        : const SizedBox(),
                    YBox(10),
                    const FormLabel(
                      text: 'Phone number',
                    ),
                    YBox(6),

                    ///TODO: To validate and show properly align error message, check smart ride
                    InternationalPhoneNumberInput(
                      focusNode: phoneNoFocusNode,
                      onInputChanged: (PhoneNumber number) {
                        code = number.dialCode!;
                      },
                      keyboardAction: TextInputAction.next,
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG,
                        leadingPadding: 0,
                        trailingSpace: false,
                        setSelectorButtonAsPrefixIcon: true,
                        showFlags: false,
                      ),
                      // selectorConfig: const SelectorConfig(
                      //   selectorType: PhoneInputSelectorType.DROPDOWN,
                      // leadingPadding: 0,
                      // trailingSpace: false,
                      // setSelectorButtonAsPrefixIcon: false,
                      // ),
                      spaceBetweenSelectorAndTextField: 0,
                      selectorButtonOnErrorPadding: 0,
                      ignoreBlank: false,

                      initialValue: number,
                      // autoValidateMode: AutovalidateMode.onUserInteraction,
                      selectorTextStyle: const TextStyle(color: Colors.black),

                      textFieldController: phoneNoController,

                      inputDecoration: InputDecoration(
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
                        // isDense: true,
                        // labelText: "Enter Phone Number",
                        hintText: "Enter Phone Number",

                        // labelStyle: TextStyle(
                        //   fontSize: 15.sp,
                        //   fontWeight: FontWeight.w400,
                        //   color: Colors.black38,
                        // ),
                        hintStyle: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black38,
                        ),
                        // contentPadding: EdgeInsets.symmetric(vertical: -2.h),
                      ),
                      formatInput: false,
                      inputBorder: InputBorder.none,
                      keyboardType: TextInputType.phone,

                      // keyboardType: const TextInputType.numberWithOptions(
                      //   signed: true,
                      //   decimal: true,
                      // ),
                      // },
                    ),

                    YBox(10),
                    const FormLabel(
                      text: 'Password',
                    ),
                    YBox(6),
                    AppTextField(
                      hintText: '*******',
                      controller: passwordController,
                      obscureText: password ? false : true,
                      focusNode: passwordFocusNode,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      // validator: (value) =>
                      //     Validator.validatePassword(value),
                      enabledBorderColor: isPasswordFilled == true
                          ? AppColors.redColor
                          : AppColors.textFormFieldBorderColor,
                      onChanged: (String? value) {
                        if (value!.length < 6) {
                          // return 'Please input a valid email address';
                          setState(() {
                            isPasswordFilled = true;
                            passwordErrorText =
                                'Password must be greater than six length';
                          });
                        } else {
                          setState(() {
                            isPasswordFilled = false;
                          });
                        }
                      },
                      // onFieldSubmitted: (value) {
                      //   if (FormStringUtils.isNotEmpty(value)) {
                      //     passwordFocusNode.requestFocus(passwordFocusNode);
                      //   } else {
                      //     FocusManager.instance.primaryFocus?.unfocus();
                      //   }
                      // },
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            password = !password;
                          });
                        },
                        child: Icon(
                          password
                              ? Icons.visibility_off
                              : Icons.visibility_sharp,
                          color: AppColors.headerTextColor1,
                        ),
                      ),
                    ),
                    isPasswordFilled == true
                        ? Text(
                            passwordErrorText,
                            style: AppTextStyle.satoshiFontText(
                              context,
                              AppColors.redColor,
                              14.sp,
                            ),
                          )
                        : const SizedBox(),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.buttonBgColor,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 0.0),
                      value: isTermToggle,
                      onChanged: (value) {
                        setState(() {
                          isTermToggle = value!;
                        });
                      },
                      title: Transform.translate(
                        offset: const Offset(-25, 0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'I agree to Repore ',
                            style: AppTextStyle.satoshiFontText(
                              context,
                              AppColors.headerTextColor1,
                              14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // context.goNamed(
                                    //   AppRoute.login.name,
                                    // );
                                  },
                                text: 'terms ',
                                style: AppTextStyle.satoshiFontText(
                                  context,
                                  AppColors.buttonBgColor,
                                  14.sp,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: '& ',
                                style: AppTextStyle.satoshiFontText(
                                  context,
                                  AppColors.buttonBgColor,
                                  14.sp,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // context.goNamed(
                                    //   AppRoute.login.name,
                                    // );
                                  },
                                text: 'conditions ',
                                style: AppTextStyle.satoshiFontText(
                                  context,
                                  AppColors.buttonBgColor,
                                  14.sp,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    YBox(10),
                    AppButton(
                      buttonText: 'Continue',
                      onPressed: () {
                        if (firstNameController.text.isEmpty ||
                            lastNameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            isFirstNameFilled == true ||
                            isLastNameFilled == true ||
                            isEmailFilled == true ||
                            isPasswordFilled == true) {
                          if (emailController.text.isEmpty) {
                            setState(() {
                              isEmailFilled = true;
                              emailErrorText = 'Email can not be empty';
                            });
                          }
                          if (firstNameController.text.isEmpty) {
                            setState(() {
                              isFirstNameFilled = true;
                              firstNameErrorText =
                                  'First Name can not be empty';
                            });
                          }
                          if (lastNameController.text.isEmpty) {
                            setState(() {
                              isLastNameFilled = true;
                              lastNameErrorText = 'Last Name can not be empty';
                            });
                          }
                          if (passwordController.text.isEmpty) {
                            setState(() {
                              isPasswordFilled = true;
                              passwordErrorText =
                                  'Password no can not be empty';
                            });
                          }
                        } else if (isTermToggle == false) {
                          showErrorToast(
                              context, 'Please agree to terms and conditions');
                        } else {
                          var register = RegisterReq(
                            email: emailController.text.trim(),
                            phone: phoneNoController.text.trim(),
                            password: passwordController.text.trim(),
                            firstname: firstNameController.text.trim(),
                            lastname: lastNameController.text.trim(),
                            address: '',
                            zipcode: '',
                            city: '',
                            state: '',
                            company: '',
                            gender: '',
                            dob: '',
                          );
                          ref
                              .read(registerProvider.notifier)
                              .register(register);
                          context.loaderOverlay.show();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

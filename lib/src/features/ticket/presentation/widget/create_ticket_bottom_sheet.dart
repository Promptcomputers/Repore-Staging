import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

class CreateTicketBottomSheet extends StatefulHookConsumerWidget {
  const CreateTicketBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTicketBottomSheetState();
}

class _CreateTicketBottomSheetState
    extends ConsumerState<CreateTicketBottomSheet> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final titleFocusNode = FocusNode();
  final serviceTypeNameController = TextEditingController();
  final serviceTypeIdController = TextEditingController();
  final serviceTypeFocusNode = FocusNode();
  final descriptionController = TextEditingController();
  final descriptionFocusNode = FocusNode();
  // final List<XFile> pickedFile = [];
  // List<File> convertedPickedFile = [];

  // @override
  // void dispose() {
  //   titleController.dispose();
  //   serviceTypeNameController.dispose();
  //   serviceTypeIdController.dispose();
  //   descriptionController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(getServiceTypeProvider);
    final createTicketVm = ref.watch(createTicketProvider);
    List<ServiceTypeDatum> item =
        vm.maybeWhen(data: (e) => e.data, orElse: () => []);
    // final pickedFileListPath = useState<List<File>>([]);
    // final pickedFilePath = useState<File>(File(''));
    // final filesListPicked = useState([]);
    // final pickedFileName = useState('');

    ref.listen<AsyncValue<CreateTicketRes>>(createTicketProvider, (T, value) {
      if (value.hasValue) {
        // context.loaderOverlay.hide();
        PreferenceManager.ticketId = value.value!.data!.ticket.id;
        PreferenceManager.ticketRef = value.value!.data!.ticket.reference;
        PreferenceManager.ticketTitle = value.value!.data!.ticket.subject;
        ref.invalidate(searchTicketProvider);
        ref.invalidate(getNofificationProvider);
        Navigator.pop(context);
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          barrierColor: AppColors.primaryColor.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0.sp),
            ),
          ),
          isScrollControlled: true,
          context: context,
          builder: (context) => const TicketCreatedBottomSheet(),
        );
      }
      if (value.hasError) {
        // context.loaderOverlay.hide();

        showErrorToast(context, value.error.toString());
      }
    });
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
            Form(
              key: formKey,
              child: Container(
                /// Don't use defined height
                // height: 420.h,
                padding: EdgeInsets.only(
                    left: 30.w, right: 30.w, top: 40.h, bottom: 80.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'New Ticket',
                          style: AppTextStyle.satoshiFontText(
                            context,
                            AppColors.primaryColor,
                            18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                          ),
                        )
                      ],
                    ),
                    YBox(10.h),
                    const FormLabel(
                      text: 'Title',
                    ),
                    YBox(6.h),
                    AppTextField(
                      controller: titleController,
                      hintText: 'Eg. My cool ticket name',
                      focusNode: titleFocusNode,
                      keyboardType: TextInputType.name,
                      validator: (value) => Validator.validateField(value,
                          errorMessage: 'Title  cannot be empty'),
                      onFieldSubmitted: (value) {
                        if (FormStringUtils.isNotEmpty(value)) {
                          titleFocusNode.requestFocus();
                        }
                      },
                    ),
                    YBox(20.h),
                    const FormLabel(
                      text: 'Service type',
                    ),
                    YBox(6.h),
                    DropdownButtonFormField<ServiceTypeDatum>(
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 28.sp,
                        color: AppColors.headerTextColor1,
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a service type';
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
                      items: item.map((ServiceTypeDatum value) {
                        return DropdownMenuItem<ServiceTypeDatum>(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          serviceTypeIdController.text = value!.id;
                        });
                      },
                    ),
                    // YBox(20.h),
                    // const FormLabel(
                    //   text: 'Description',
                    // ),
                    // YBox(6.h),
                    // AppTextField(
                    //   maxLines: 4,
                    //   controller: descriptionController,
                    //   hintText: 'My cool project is about...',
                    //   focusNode: descriptionFocusNode,
                    //   keyboardType: TextInputType.name,
                    //   validator: (value) => Validator.validateField(value,
                    //       errorMessage: 'Title  cannot be empty'),
                    //   onFieldSubmitted: (value) {
                    //     if (FormStringUtils.isNotEmpty(value)) {
                    //       descriptionFocusNode.requestFocus();
                    //     }
                    //   },
                    // ),
                    // YBox(20.h),
                    // const FormLabel(
                    //   text: 'Upload',
                    // ),
                    // YBox(6.h),
                    // GestureDetector(
                    //   // onTap: () async {
                    //   //   // Navigator.of(context).pop();
                    //   //   //Pick image form gallery
                    //   //   final picker = ImagePicker();
                    //   //   List<XFile> images = await picker.pickMultiImage();
                    //   //   setState(() {
                    //   //     pickedFile.addAll(images.toList());
                    //   //     convertedPickedFile = pickedFile
                    //   //         .map<File>((xfile) => File(xfile.path))
                    //   //         .toList();
                    //   //   });
                    //   // },
                    //   onTap: () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (context) {
                    //         return StatefulBuilder(builder: (BuildContext
                    //                 context,
                    //             StateSetter
                    //                 setModalState /*You can rename this!*/) {
                    //           return FittedBox(
                    //             child: AlertDialog(
                    //               content: Column(
                    //                 children: [
                    //                   GestureDetector(
                    //                     onTap: () async {
                    //                       Navigator.of(context).pop();
                    //                       //Pick image form gallery
                    //                       final picker = ImagePicker();
                    //                       List<XFile> images =
                    //                           await picker.pickMultiImage();
                    //                       if (images.isEmpty) return;
                    //                       setState(() {
                    //                         pickedFile.addAll(images.toList());
                    //                         convertedPickedFile = pickedFile
                    //                             .map<File>(
                    //                                 (xfile) => File(xfile.path))
                    //                             .toList();
                    //                       });
                    //                       // if (images.isNotEmpty) {
                    //                       //   setState(() {
                    //                       //     pickedFile
                    //                       //         .addAll(images.toList());
                    //                       //     convertedPickedFile = pickedFile
                    //                       //         .map<File>((xfile) =>
                    //                       //             File(xfile.path))
                    //                       //         .toList();
                    //                       //   });
                    //                       // }
                    //                     },
                    //                     child: Text(
                    //                       'Choose from gallery',
                    //                       style: AppTextStyle.bodyText(
                    //                         context,
                    //                         AppColors.buttonBgColor,
                    //                         14.sp,
                    //                         fontWeight: FontWeight.w500,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   YBox(20.h),
                    //                   GestureDetector(
                    //                     onTap: () async {
                    //                       Navigator.of(context).pop();
                    //                       final picker = ImagePicker();
                    //                       //Pick image form camera source, by alowing user to snap using the device camera
                    //                       final snapPicture =
                    //                           await picker.pickImage(
                    //                               source: ImageSource.camera);
                    //                       if (snapPicture == null) return;
                    //                       setState(() {
                    //                         pickedFile.add(snapPicture);
                    //                         convertedPickedFile = pickedFile
                    //                             .map<File>(
                    //                                 (xfile) => File(xfile.path))
                    //                             .toList();
                    //                       });
                    //                       // if (snapPicture != null) {
                    //                       //   setState(() {
                    //                       //     pickedFile.add(snapPicture);
                    //                       //     convertedPickedFile = pickedFile
                    //                       //         .map<File>((xfile) =>
                    //                       //             File(xfile.path))
                    //                       //         .toList();
                    //                       //   });
                    //                       // }
                    //                     },
                    //                     child: Text(
                    //                       'Choose from camera',
                    //                       style: AppTextStyle.bodyText(
                    //                         context,
                    //                         AppColors.buttonBgColor,
                    //                         14.sp,
                    //                         fontWeight: FontWeight.w500,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           );
                    //         });
                    //       },
                    //     );
                    //   },
                    //   child: Container(
                    //     // padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    //     // color: AppColors.buttonBgColor2.withOpacity(0.5),
                    //     child: Container(
                    //       height: 114.h,
                    //       width: 170.w,
                    //       padding: EdgeInsets.only(
                    //           top: 20.h, bottom: 20.h, left: 18.w),
                    //       decoration: DottedDecoration(
                    //         shape: Shape.box,
                    //         color: AppColors.buttonBgColor2,
                    //         borderRadius: BorderRadius.circular(12.r),
                    //         strokeWidth: 1.w,
                    //       ),
                    //       child: Column(
                    //         children: [
                    //           Image.asset(AppIcon.uploadIconColored),
                    //           YBox(5.h),
                    //           Text(
                    //             'Upload files',
                    //             style: AppTextStyle.bodyText(
                    //               context,
                    //               AppColors.buttonBgColor,
                    //               14.sp,
                    //               fontWeight: FontWeight.w500,
                    //             ),
                    //           ),
                    //           YBox(5.h),
                    //           Text(
                    //             'PNG, JPG, JPEG only',
                    //             // 'PNG, JPG, JPEG only (max. 3mb)',
                    //             style: AppTextStyle.bodyText(
                    //               context,
                    //               AppColors.buttonBgColor,
                    //               12.sp,
                    //               fontWeight: FontWeight.w400,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // GestureDetector(
                    //   onTap: () async {
                    //     final filePicked = await FilePicker.platform.pickFiles(
                    //       allowMultiple: true,
                    //       type: FileType.custom,
                    //       allowedExtensions: ['doc', 'pdf'],
                    //       withData: true,
                    //       withReadStream: true,
                    //     );
                    //     if (filePicked == null) return;
                    //     List<File> files = filePicked.paths
                    //         .map((path) => File(path!))
                    //         .toList();
                    //     pickedFileListPath.value = files;
                    //     filesListPicked.value.add(files);
                    //     // pickedFilePath.value =
                    //     //     filePicked.paths.map((path) => File(path!)).toList();
                    //     //  List<File> files = filePicked.paths.map((path) => File(path!)).toList();
                    //     final file = filePicked.files.first;
                    //     pickedFilePath.value = File(file.path!);
                    //     pickedFileName.value = file.name;
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    //     decoration: BoxDecoration(
                    //       color: AppColors.whiteColor,
                    //       border: Border.all(
                    //           width: 1.w,
                    //           color: AppColors.textFormFieldBorderColor),
                    //       borderRadius: BorderRadius.circular(16.r),
                    //     ),
                    //     child: Column(
                    //       children: [
                    //         Image.asset(AppIcon.uploadIcon),
                    //         YBox(6.h),
                    //     Text(
                    //       pickedFileName.value.isEmpty
                    //           ? 'Click to upload'
                    //           : pickedFileName.value,
                    //       // 'Click to upload',
                    //       style: AppTextStyle.bodyText(
                    //           context,
                    //           AppColors.buttonBgColor,
                    //           pickedFileName.value.isEmpty ? 14.sp : 12.sp,
                    //           fontWeight: FontWeight.w600),
                    //     ),
                    //   ],
                    // ),
                    //   ),
                    // ),
                    // SizedBox(height: pickedFile.isEmpty ? 0.0 : 20.h),
                    // pickedFile.isEmpty
                    //     ? const SizedBox()
                    //     : SizedBox(
                    //         height: 80.h,
                    //         child: ListView.separated(
                    //             shrinkWrap: true,
                    //             scrollDirection: Axis.horizontal,
                    //             itemCount: pickedFile.length,
                    //             separatorBuilder: (context, index) =>
                    //                 SizedBox(width: 10.w),
                    //             itemBuilder: (context, index) {
                    //               final images = pickedFile[index];
                    //               // final image = File();
                    //               return Stack(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 72.w,
                    //                     height: 72.h,
                    //                     child: FittedBox(
                    //                       child: ClipRRect(
                    //                         borderRadius:
                    //                             BorderRadius.circular(8.r),
                    //                         child: Image.file(
                    //                           File(images.path),
                    //                           width: 50.w,
                    //                           height: 56.h,
                    //                           fit: BoxFit.cover,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   Positioned(
                    //                     right: 0,
                    //                     child: GestureDetector(
                    //                       onTap: () {
                    //                         setState(() {
                    //                           pickedFile.removeAt(index);
                    //                         });
                    //                       },
                    //                       child: CircleAvatar(
                    //                         radius: 10.r,
                    //                         backgroundColor:
                    //                             AppColors.primaryTextColor2,
                    //                         child: Icon(
                    //                           Icons.close,
                    //                           color: AppColors.whiteColor,
                    //                           size: 15.sp,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   )
                    //                 ],
                    //               );
                    //             }),
                    //       ),
                    YBox(30.h),
                    AppButton(
                      buttonText: "Create ticket",
                      isLoading: createTicketVm.isLoading,
                      onPressed: () {
                        // log('File Picked Lenght: ${convertedPickedFile.length}');
                        if (formKey.currentState!.validate()) {
                          // log('file : ${pickedFileListPath.value}');
                          ref.read(createTicketProvider.notifier).createTicket(
                                titleController.text.trim(),
                                PreferenceManager.userId,
                                serviceTypeIdController.text,
                              );
                          // ref.read(createTicketProvider.notifier).createTicket(
                          //       convertedPickedFile.isEmpty
                          //           ? []
                          //           : convertedPickedFile.toList(),
                          //       titleController.text.trim(),
                          //       PreferenceManager.userId,
                          //       serviceTypeIdController.text,
                          //       descriptionController.text.trim(),
                          //     );
                          // context.loaderOverlay.show();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

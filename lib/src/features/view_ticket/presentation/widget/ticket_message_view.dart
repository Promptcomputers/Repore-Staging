import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:repore/lib.dart';

class TicketMessageView extends StatefulHookConsumerWidget {
  final String id;
  const TicketMessageView({required this.id, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TicketMessageViewState();
}

class _TicketMessageViewState extends ConsumerState<TicketMessageView> {
  final messageController = TextEditingController();
  String text = '';
  // bool isMyMessage = false;

  void updateText() {
    setState(() {
      text = messageController.text;
    });
  }

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToLastItem();
    });
  }

  // void scrollToLastItem() {
  //   _scrollController.animateTo(
  //     _scrollController.position.maxScrollExtent,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeOut,
  //   );
  // }

  void scrollToLastItem() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pickedFile = useState("");
    final vm = ref.watch(getTicketMessages(widget.id));
    final sendMessageVm = ref.watch(sendMessageProvider);
    // FocusScopeNode currentFocus = FocusScope.of(context);
    final _focus = FocusNode();
    // bool setIsHasFocus = false;

    // _focus.addListener(() {
    //   if (_focus.hasFocus) {
    //     setIsHasFocus = true;
    //     log('setIsHasFocus $setIsHasFocus');
    //     // setState(() {
    //     //   setIsHasFocus = true;
    //     // });
    //   } else {
    //     setIsHasFocus = false;
    //     // setState(() {
    //     //   setIsHasFocus = false;
    //     // });
    //   }
    // });
    ref.listen<AsyncValue>(sendMessageProvider, (T, value) {
      if (value.hasValue) {
        FocusManager.instance.primaryFocus?.unfocus();
        text = '';
        pickedFile.value = "";
        messageController.clear();

        ref.invalidate(getTicketMessages(widget.id));
        log('Error1 ${value.error}');
      }
      log('Error2 ${value.error}');
      if (value.hasError) {
        log('Erro3r ${value.error.toString}');
        showErrorToast(context, 'An error occured');
      }
    });
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          border: Border.all(
            color: AppColors.homeContainerBorderColor,
          ),
        ),
        child: vm.when(
          error: (error, stackTrace) => Text(
            error.toString(),
            style: AppTextStyle.satoshiFontText(
              context,
              AppColors.notificationHeaderColor,
              14.sp,
            ),
          ),
          // error: (error, stackTrace) => const SizedBox(),
          loading: () => Center(
            child: Text(
              "Loading Chats",
              style: AppTextStyle.satoshiFontText(
                context,
                AppColors.notificationHeaderColor,
                14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          data: (value) {
            return Stack(
              children: [
                value.data.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 90.h),
                        child: const Center(
                          child: EmptyNotificationStateWidget(
                            message: 'You don’t have an agent yet',
                          ),
                        ),
                      )
                    //  padding: EdgeInsets.only(
                    //         bottom: MediaQuery.of(context).viewInsets.bottom)
                    : SizedBox(
                        height: 480.h,
                        // height: 48÷0.h,
                        //TODO: How to calculate the height and scroll effect when text formfield is focus, not to use hardcpded heightor bottom padding
                        child: ListView.separated(
                          physics: AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          padding: EdgeInsets.only(
                            left: 20.w,
                            right: 20.w,
                            top: 20.h,
                            //TODO: Hack
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom == 0
                                    ? 0.h
                                    : 100.h,
                            // bottom: setIsHasFocus == true ? 150.h : 50.h,
                          ),
                          // padding: EdgeInsets.only(bottom: 50.h),
                          shrinkWrap: true,
                          reverse: true,
                          // reverse: value.data.length < 6 ? false : true,
                          separatorBuilder: (context, index) => YBox(10),
                          itemCount: value.data.length,
                          itemBuilder: (context, index) {
                            // for (var id in value.data) {
                            //   if (id.from.id == PreferenceManager.userId) {
                            //     isMyMessage = true;
                            //   }
                            //   // isMyMessage =
                            //   //     (id.from.id == PreferenceManager.userId);

                            // }
                            final chat = value.data;
                            // final chat = value.data.reversed.toList();
                            final item = chat[index];
                            String formattedTime =
                                DateFormat('h.mma').format(item.createdAt);
                            // String formattedTime =
                            //     DateFormat('kk:mm').format(item.createdAt);
                            // String formattedTime =
                            //     DateFormat('kk:mm a').format(item.createdAt);
                            // return CurrentUserChatBox();
                            //                 final isConsecutive =
                            // index > 0 && message['sender'] == messages[index - 1]['sender'];
                            // final isConsecutive = index > 0 &&
                            //     (item.from!.role == "ADMIN") ==
                            //         (chat[index - 1].from!.role == "ADMIN");
                            if (item.from == null) {
                              return AgentChatBox(
                                // hideSenderInfo: isConsecutive,
                                msg: item.message,
                                dateCreated: formattedTime,
                                userName: item.from == null
                                    ? ''
                                    : item.from!.firstname,
                                role: item.from == null ? '' : item.from!.role,
                                type: item.type,
                                invoiceId: item.invoiceId,
                                invoiceTotal: item.invoiceTotal ?? 0,
                                subject: item.message,
                                invoiceType: item.invoiceType,
                                // attachment: item.attachment?.name,
                              );
                            }
                            if (item.from!.id == PreferenceManager.userId) {
                              return CurrentUserChatBox(
                                msg: item.message,
                                dateCreated: formattedTime,
                                userName: item.from == null
                                    ? ''
                                    : item.from!.firstname,
                                attachment: item.attachment == null
                                    ? ''
                                    : item.attachment!.name!,
                              );
                            } else {
                              return AgentChatBox(
                                // hideSenderInfo: isConsecutive,
                                msg: item.message,
                                dateCreated: formattedTime,
                                userName: item.from == null
                                    ? ''
                                    : item.from!.firstname,
                                role: item.from == null ? '' : item.from!.role,
                                type: item.type,
                                invoiceId: item.invoiceId,
                                invoiceTotal: item.invoiceTotal,
                                subject: item.message,
                                invoiceType: item.invoiceType,
                                // attachment: item.attachment?.name,
                              );
                            }

                            // return !isMyMessage
                            //     ? AgentChatBox(
                            //         msg: item.message,
                            //         dateCreated: formattedTime,
                            //         userName: item.from.firstname,
                            //       )
                            //     : CurrentUserChatBox(
                            //         msg: item.message,
                            //         dateCreated: formattedTime,
                            //         userName: item.from.firstname,
                            //       );
                          },
                        ),
                      ),
                pickedFile.value.isEmpty
                    ? const SizedBox()
                    : Positioned(
                        bottom: 100.h,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.w, top: 20.h),
                          child: Stack(
                            children: [
                              Container(
                                height: 50.h,
                                width: 50.w,
                                color: Colors.grey.shade300,
                                child: Image.file(
                                  File(pickedFile.value),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: -5.w,
                                top: -10.h,
                                child: InkWell(
                                  onTap: () {
                                    pickedFile.value = "";
                                  },
                                  child: CircleAvatar(
                                    radius: 10.r,
                                    backgroundColor: Colors.red,
                                    child: Icon(
                                      Icons.close,
                                      size: 15.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 20.w, right: 20.w, bottom: 10.h, top: 10.h),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      border: Border.all(
                        color: AppColors.homeContainerBorderColor,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20.w, bottom: 5.h, top: 5.h),
                      decoration: BoxDecoration(
                        color: AppColors.homeContainerBorderColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // final filePicked =
                              //     await FilePicker.platform.pickFiles(
                              //   //CHange due to endpint returning just one file when viewing msg
                              //   allowMultiple: false,
                              //   type: FileType.custom,
                              //   allowedExtensions: [
                              //     'doc',
                              //     'pdf',
                              //     'jpg',
                              //     'png',
                              //     'doc',
                              //     'jpeg',
                              //   ],
                              //   withData: true,
                              //   withReadStream: true,
                              // );
                              // if (filePicked == null) return;

                              // pickedFile.value =
                              //     filePicked.files.single.path!;

                              // var result = await ref
                              //     .read(fileProvider)
                              //     .addAttachment();
                              var result = await ref
                                  .read(fileProvider)
                                  .pickImageFromGallery();
                              log("result==> $result");
                              pickedFile.value = result;
                            },
                            child: Image.asset(AppIcon.cameraIcon),
                          ),
                          XBox(5),
                          Flexible(
                            child: AppTextField(
                              hintText: 'Say Something',
                              hintStyle: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.primaryTextColor2,
                                12.sp,
                              ),
                              focusNode: _focus,
                              // keyboardType: TextInputType.multiline,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              controller: messageController,
                              textInputAction: TextInputAction.done,
                              // onEditingComplete: () =>
                              //     FocusManager.instance.primaryFocus?.unfocus(),
                              // onFieldSubmitted: (value) =>
                              //     FocusManager.instance.primaryFocus?.unfocus(),
                              onChanged: (value) {
                                updateText();
                              },
                            ),
                          ),
                          // sendMessageVm.isLoading
                          //     ? const SizedBox()
                          //     :
                          Container(
                            // alignment: Alignment.center,
                            // margin: EdgeInsets.only(right: 5.w),
                            width: 30.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              color:
                                  (text.isEmpty && pickedFile.value.isEmpty) ||
                                          sendMessageVm.isLoading
                                      ? AppColors.textFormFieldBorderColor
                                      : AppColors.buttonBgColor,
                              borderRadius: BorderRadius.circular(
                                16.r,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: (text.isEmpty &&
                                          pickedFile.value.isEmpty) ||
                                      sendMessageVm.isLoading
                                  ? null
                                  : () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      ref
                                          .read(sendMessageProvider.notifier)
                                          .sendMessage(
                                            pickedFile.value,
                                            widget.id,
                                            PreferenceManager.userId,
                                            text,
                                          );
                                    },
                              child: Icon(
                                Icons.send,
                                color: AppColors.whiteColor,
                                size: 15.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                // Positioned(
                //   bottom: 0,
                //   child: Container(
                // padding: EdgeInsets.only(
                //     left: 20.w, right: 20.w, bottom: 20.h, top: 20.h),
                // width: MediaQuery.of(context).size.width,
                // decoration: BoxDecoration(
                //   color: AppColors.whiteColor,
                //   border: Border.all(
                //     color: AppColors.homeContainerBorderColor,
                //   ),
                // ),
                //     child: SizedBox(
                //       width: 330.w,
                //       child: AppTextField(
                //         hintText: 'Say Something',
                // hintStyle: AppTextStyle.bodyText(
                //   context,
                //   AppColors.primaryTextColor2,
                //   12.sp,
                // ),
                //         controller: messageController,
                //         filled: true,
                //         filledColor: AppColors.homeContainerBorderColor,
                //         preffixIcon: Image.asset(
                //           AppIcon.cameraIcon,
                //         ),
                //         suffixIcon: sendMessageVm.isLoading
                //             ? const SizedBox()
                //             : Container(
                //                 // alignment: Alignment.center,
                //                 margin: EdgeInsets.only(right: 5.w),
                //                 decoration: BoxDecoration(
                //                   color: text.isEmpty
                //                       ? AppColors.textFormFieldBorderColor
                //                       : AppColors.buttonBgColor,
                //                   borderRadius: BorderRadius.circular(
                //                     16.r,
                //                   ),
                //                 ),
                //                 child: GestureDetector(
                //                   onTap: text.isEmpty
                //                       ? null
                //                       : () {
                //                           FocusManager.instance.primaryFocus
                //                               ?.unfocus();
                //                           ref
                //                               .read(
                //                                   sendMessageProvider.notifier)
                //                               .sendMessage(
                //                                 text,
                //                                 PreferenceManager.userId,
                //                                 widget.id,
                //                               );
                //                         },
                // child: const Icon(
                //   Icons.send,
                //   color: AppColors.whiteColor,
                // ),
                //                 ),
                //               ),
                // onChanged: (value) {
                //   updateText();
                // },
                //       ),
                //     ),
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}

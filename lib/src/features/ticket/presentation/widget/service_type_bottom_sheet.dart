import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ServiceTypeBottomSheet extends ConsumerStatefulWidget {
  final TextEditingController serviceTypeName;
  final TextEditingController serviceTypeId;
  const ServiceTypeBottomSheet(
      {required this.serviceTypeId, required this.serviceTypeName, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ServiceTypeBottomSheetState();
}

class _ServiceTypeBottomSheetState
    extends ConsumerState<ServiceTypeBottomSheet> {
  // @override
  // void dispose() {
  //   widget.serviceTypeName.dispose();
  //   widget.serviceTypeId.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // final vm = ref.watch(getServiceTypeProvider);
    return Container(
      height: 200.h,
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 40.h),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_assignment/utils/app_color.dart';

final searchController = TextEditingController();

SizedBox searchbox() {
  return SizedBox(
    height: 52.h,
    child: TextField(
      maxLines: 1,
      controller: searchController,
      // textAlignVertical: TextAlignVertical.top,
      textInputAction: TextInputAction.search,
      style: TextStyle(fontSize: 15.sp, color: AppColors.appcolor),
      onSubmitted: (value) => () {},
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              // borderSide: BorderSide(width: 1),
              borderSide: BorderSide(color: AppColors.greycolor, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          errorBorder: const OutlineInputBorder(
              // borderSide: BorderSide(width: 1),
              borderSide: BorderSide(color: AppColors.greycolor, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          focusedBorder: const OutlineInputBorder(
              // borderSide: BorderSide(width: 1),
              borderSide: BorderSide(color: AppColors.greycolor, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greycolor, width: 1),
              // borderSide: BorderSide(width: 1),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          // filled: true,
          prefixIcon: Icon(Icons.search_rounded,
              color: const Color(0xff4E4E52), size: 22.sp),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greycolor, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          hintText: 'Search for pooja',
          // floatingLabelAlignment: FloatingLabelAlignment.center,
          hintStyle: TextStyle(fontSize: 15.sp, color: AppColors.appblue)),
    ),
  );
}

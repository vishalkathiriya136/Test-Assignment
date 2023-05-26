import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_assignment/src/screen/hello_world_screen.dart';
import 'package:test_assignment/theme/app_assets.dart';
import 'package:test_assignment/utils/app_color.dart';
import 'package:test_assignment/utils/app_text.dart';
import 'package:test_assignment/utils/strings.dart';
import 'package:test_assignment/utils/text_styles.dart';

class HelloWorld2 extends StatefulWidget {
  const HelloWorld2({super.key});

  @override
  State<HelloWorld2> createState() => _HelloWorld2State();
}

class _HelloWorld2State extends State<HelloWorld2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whitecolor,
        appBar: AppBar(
          backgroundColor: AppColors.whitecolor,
          elevation: 0,
          leading: Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: AppColors.appcolor))),
          centerTitle: true,
          title: AppText(
              text: AppStrings.page2, style: AppTextStyles.size18WithW600),
          actions: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Image.asset(Ig.search, color: AppColors.appcolor),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              smart(),
              SizedBox(height: 30.h),
              testPageText(),
              SizedBox(height: 40.h)
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [previousbutton()],
        ),
      ),
    );
  }

  Widget smart() {
    return Center(child: Image.asset(Ig.flutter));
  }

  Widget testPageText() {
    return AppText(
        text: AppStrings.testpage, style: AppTextStyles.size25WithBold);
  }

  Widget previousbutton() {
    return Column(
      children: [
        const Divider(thickness: 1),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const HelloWordScreen();
                  },
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.appblue),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15.w, right: 15.w, top: 8.h, bottom: 8.h),
                  child: AppText(
                      text: AppStrings.previous,
                      style: AppTextStyles.size15WithW600),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

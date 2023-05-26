import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_assignment/src/screen/hello_world2_screen.dart';
import 'package:test_assignment/theme/app_assets.dart';
import 'package:test_assignment/utils/app_color.dart';
import 'package:test_assignment/utils/app_text.dart';
import 'package:test_assignment/utils/strings.dart';
import 'package:test_assignment/utils/text_styles.dart';

class HelloWordScreen extends StatefulWidget {
  const HelloWordScreen({super.key});

  @override
  State<HelloWordScreen> createState() => _HelloWordScreenState();
}

class _HelloWordScreenState extends State<HelloWordScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whitecolor,
        appBar: AppBar(
          backgroundColor: AppColors.whitecolor,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Image.asset(
              Ig.drawer,
              color: AppColors.appcolor,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                Ig.notification,
                color: AppColors.appcolor,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              helloWorld(),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            nextbutton(),
          ],
        ),
      ),
    );
  }

  Widget helloWorld() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: AppStrings.hello, style: AppTextStyles.size25With600),
        SizedBox(height: 5.h),
        AppText(text: AppStrings.world, style: AppTextStyles.size25WithBold),
      ],
    );
  }

  Widget nextbutton() {
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
                    return const HelloWorld2();
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
                      text: AppStrings.next,
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

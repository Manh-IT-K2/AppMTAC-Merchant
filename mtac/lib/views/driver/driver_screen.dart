import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mtac/constants/text.dart';
import 'package:mtac/controllers/driver_controller.dart';
import 'package:mtac/data/driver_screen/item_note_important.dart';
import 'package:mtac/themes/color.dart';
import 'package:mtac/utils/theme_text.dart';
import 'package:sizer/sizer.dart';

class DriverScreen extends StatelessWidget {
  DriverScreen({super.key});

  // initial DriverController
  final DriverController _driverController = Get.put(DriverController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: const Color(0xFF0A4564),
                size: 5.w,
              ),
            ),
            Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.2),
                  shape: BoxShape.circle),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.notifications_none_outlined,
                      size: 6.w,
                      color: kPrimaryColor,
                    ),
                  ),
                  Positioned(
                    top: 3.w,
                    right: 3.5.w,
                    child: Container(
                      width: 1.5.w,
                      height: 1.5.w,
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _HeaderDriverScreen(),
              SizedBox(
                height: 3.w,
              ),
              _BodyDriverScreen(driverController: _driverController),
              const _BottomDriverScreen(),
              SizedBox(
                height: 5.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomDriverScreen extends StatelessWidget {
  const _BottomDriverScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          txtTitleNoteImportantD,
          style: PrimaryFont.titleTextMedium().copyWith(color: Colors.red),
        ),
        Text(
          txtSubTitleNoteImportantD,
          style: PrimaryFont.bodyTextMedium().copyWith(
            color: Colors.black.withOpacity(0.8),
          ),
        ),
        SizedBox(
          height: 3.w,
        ),
        SizedBox(
          height: 30.h,
          child: ListView.builder(
            itemCount: noteImportantData.length,
            itemBuilder: (context, index) {
              final note = noteImportantData[index];
              return _ItemNoteImportant(
                title: note.nameNote,
                subTitle: note.contentNote,
                hour: note.hourNote,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _BodyDriverScreen extends StatelessWidget {
  const _BodyDriverScreen({
    super.key,
    required DriverController driverController,
  }) : _driverController = driverController;

  final DriverController _driverController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          txtScheduleHighlightD,
          style: PrimaryFont.titleTextMedium().copyWith(color: Colors.black),
        ),
        SizedBox(
          height: 3.w,
        ),
        SizedBox(
          height: 20.w,
          child: Obx(
            () => ListView.builder(
              controller: _driverController.scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _driverController.daysInMonth.length,
              itemBuilder: (context, index) {
                DateTime day = _driverController.daysInMonth[index];
                bool isToday = day.day ==
                        _driverController.currentDate.value.day &&
                    day.month == _driverController.currentDate.value.month &&
                    day.year == _driverController.currentDate.value.year;
                List<int> highlightedDays = [
                  6,
                  10,
                  _driverController.currentDate.value.day,
                  22,
                  26,
                  29
                ];
                bool isHighlight = highlightedDays.contains(day.day);
                return _ItemDayOfWeek(
                  day: day.day.toString(),
                  weekdays: _driverController.getWeekdayShortName(day),
                  statusToday: isToday,
                  statusScheduleHighlight: isHighlight,
                );
              },
            ),
          ),
        ),
        SizedBox(height: 5.w),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                txtTripColectionTodayD,
                style:
                    PrimaryFont.titleTextMedium().copyWith(color: Colors.black),
              ),
              SizedBox(height: 5.w),
              SizedBox(
                height: 42.w,
                child: ListView.builder(
                  //shrinkWrap: true,
                  itemCount: _driverController.tripTimes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 5.w),
                      child: _ItemTripToday(
                        hour: _driverController.tripTimes[index],
                        addressBusiness:
                            'Bệnh viện Nhi Đồng 1 Bệnh viện Nhi Đồng 1 Bệnh viện Nhi Đồng 1 Bệnh viện Nhi Đồng 1',
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeaderDriverScreen extends StatelessWidget {
  const _HeaderDriverScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: txtHelloD,
            style: PrimaryFont.bodyTextMedium()
                .copyWith(color: Colors.grey, height: 1.5),
            children: <TextSpan>[
              TextSpan(
                text: "Phạm Huỳnh Tín",
                style:
                    PrimaryFont.titleTextMedium().copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "51C - 7373",
              style: PrimaryFont.headerTextBold().copyWith(color: Colors.black),
            ),
            Text(
              "MSX: 7362",
              style: PrimaryFont.bodyTextBold().copyWith(color: Colors.black),
            ),
          ],
        ),
        SizedBox(
          height: 3.w,
        ),
        Text(
          txtUtilDriverD,
          style: PrimaryFont.titleTextMedium().copyWith(color: Colors.black),
        ),
        Row(
          children: [
            _UtilDriver(
              color: Colors.purple.withOpacity(0.2),
              icon: HugeIcons.strokeRoundedCalendar03,
              title: txtTitleScheduleColectionD,
              subTitle: txtSubTitleScheduleColectionD,
            ),
            const SizedBox(
              width: 16,
            ),
            _UtilDriver(
              color: Colors.greenAccent.withOpacity(0.2),
              icon: Icons.trending_down,
              title: txtTitleStatisticalD,
              subTitle: txtSubTitleStatisticalD,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            _UtilDriver(
              color: Colors.green.withOpacity(0.1),
              icon: HugeIcons.strokeRoundedCustomerService01,
              title: txtTitleHelpD,
              subTitle: txtSubTitleHelpD,
            ),
            const SizedBox(
              width: 16,
            ),
            _UtilDriver(
              color: Colors.orange.withOpacity(0.2),
              icon: HugeIcons.strokeRoundedSmartPhone01,
              title: txtTitleHistoryD,
              subTitle: txtSubTitleHistoryD,
            ),
          ],
        ),
      ],
    );
  }
}

class _ItemNoteImportant extends StatelessWidget {
  const _ItemNoteImportant({
    super.key,
    required this.title,
    required this.subTitle,
    required this.hour,
  });

  final String title, subTitle, hour;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: double.infinity,
      height: 18.w,
      decoration: BoxDecoration(
        color: const Color(0xFF8572FE),
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 3.w,
          ),
          Container(
            width: 15.w,
            height: 15.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(3.w),
            ),
            child: Icon(
              HugeIcons.strokeRoundedCalendar02,
              size: 8.w,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 2.w,
                ),
                Text(
                  title,
                  style:
                      PrimaryFont.bodyTextBold().copyWith(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subTitle,
                  style: PrimaryFont.bodyTextMedium()
                      .copyWith(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_filled,
                      size: 5.w,
                      color: Colors.white,
                    ),
                    Text(
                      hour,
                      style: PrimaryFont.bodyTextBold()
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.w,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
        ],
      ),
    );
  }
}

class _ItemTripToday extends StatelessWidget {
  const _ItemTripToday({
    super.key,
    required this.hour,
    required this.addressBusiness,
  });
  final String hour, addressBusiness;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hour,
          style: PrimaryFont.bodyTextMedium().copyWith(color: Colors.black),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          width: 60.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10.w),
          ),
          child: Center(
            child: Text(
              addressBusiness,
              style: PrimaryFont.bodyTextMedium().copyWith(color: Colors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemDayOfWeek extends StatelessWidget {
  const _ItemDayOfWeek({
    super.key,
    required this.day,
    required this.weekdays,
    required this.statusToday,
    required this.statusScheduleHighlight,
  });

  final String day, weekdays;
  final bool statusToday, statusScheduleHighlight;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 13.w,
      height: 20.w,
      decoration: BoxDecoration(
        color:
            statusToday ? kPrimaryColor.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(5.w),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text.rich(
            TextSpan(
              text: "$day\n",
              style: PrimaryFont.headerTextBold().copyWith(
                  color: statusToday ? Colors.red : Colors.black, height: 1.2),
              children: <TextSpan>[
                TextSpan(
                  text: weekdays,
                  style: PrimaryFont.bodyTextMedium()
                      .copyWith(color: statusToday ? Colors.red : Colors.black),
                ),
              ],
            ),
          ),
          statusScheduleHighlight
              ? Container(
                  width: 2.w,
                  height: 2.w,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class _UtilDriver extends StatelessWidget {
  const _UtilDriver({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subTitle,
  });

  final IconData icon;
  final Color color;
  final String title, subTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2.w),
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      width: 50.w - 24,
      height: 30.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 7.w,
            color: Colors.black,
          ),
          SizedBox(
            height: 2.w,
          ),
          Text(
            title,
            style: PrimaryFont.titleTextBold().copyWith(color: Colors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 2.w,
          ),
          Text(
            subTitle,
            style: PrimaryFont.bodyTextMedium().copyWith(color: Colors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

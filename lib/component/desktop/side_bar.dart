import 'package:calendar_app/util/color/app_color.dart';
import 'package:calendar_app/util/color/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:go_router/go_router.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: appColorList[AppColor.sideBarBackground],
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(
                color: appFontList[AppFont.white],
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            title: Text(
              '\u{1F4C5} Calendar',
              style: TextStyle(
                color: appFontList[AppFont.white],
                fontWeight: FontWeight.w900,
                fontSize: 25
              ),
            ),
            onTap: () {
              context.go('/calendar');
            },
          ),
        ],
      ),
    );
  }
}

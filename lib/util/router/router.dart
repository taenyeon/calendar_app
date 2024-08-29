import 'package:calendar_app/page/calendar_page.dart';
import 'package:calendar_app/page/main_page.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => MainPage(),
    ),
    GoRoute(
      path: '/calendar',
      builder: (BuildContext context, GoRouterState state) =>
          const CalendarPage(),
    ),
  ],
);

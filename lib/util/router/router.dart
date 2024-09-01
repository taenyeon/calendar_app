import 'package:calendar_app/page/calendar_page.dart';
import 'package:calendar_app/page/main_page.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';

import '../../page/login_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          NoTransitionPage(child: MainPage(child: LoginPage())),
    ),
    GoRoute(
      path: '/calendar',
      pageBuilder: (BuildContext context, GoRouterState state) =>
      const NoTransitionPage(child: MainPage(child: CalendarPage()))
    ),
  ],
);

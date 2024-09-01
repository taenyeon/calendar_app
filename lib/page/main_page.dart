import 'package:calendar_app/component/desktop/side_bar.dart';
import 'package:calendar_app/entity/jwt_token.dart';
import 'package:calendar_app/provider/auth_provider.dart';
import 'package:calendar_app/util/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    JwtToken jwtToken = ref.watch(authViewModelProvider);

    if (jwtToken == null) {
      context.go('/login');
    }

    return Scaffold(
      backgroundColor: appColorList[AppColor.background],
      body: Row(
        children: [
          const Flexible(
            flex: 4,
            child: SideBar(),
          ),
          Flexible(
            flex: 6,
            child: child,
          ),
        ],
      ),
    );
  }
}

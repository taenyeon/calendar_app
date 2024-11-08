import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarDetailDialog extends ConsumerWidget {
  const CalendarDetailDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("팝업")],
      ),
    );
  }
}

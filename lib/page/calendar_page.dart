import 'package:calendar_app/entity/calendar.dart';
import 'package:calendar_app/provider/calendar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/weekday.dart';

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Calendar calendar = ref.watch(calendarViewModelProvider);
    List<Weekday> headers = Weekday.values;
    CalendarViewModel calendarViewModel =
        ref.read(calendarViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('calendar'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                '${calendar.month} / ${calendar.year}',
                style: const TextStyle(fontSize: 20),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: headers.map((e) => Text(e.code)).toList(),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
              Expanded(
                child: GridView.builder(
                  itemCount: calendar.dates.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1 / 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (calendar.dates[index].month != calendar.month) {
                      return Text(
                        '${calendar.dates[index].day}',
                        style: const TextStyle(color: Colors.grey),
                      );
                    }
                    if (calendar.dates[index].weekday == Weekday.saturday) {
                      return Text(
                        '${calendar.dates[index].day}',
                        style: const TextStyle(color: Colors.blue),
                      );
                    }
                    if (calendar.dates[index].isHoliday) {
                      return Text(
                        '${calendar.dates[index].day}',
                        style: const TextStyle(color: Colors.red),
                      );
                    }
                    return Text('${calendar.dates[index].day}');
                  },
                ),
              ),
            ],
          )),
    );

    throw UnimplementedError();
  }
}

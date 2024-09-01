import 'package:calendar_app/constant/calendar_date_type.dart';
import 'package:calendar_app/entity/calendar.dart';
import 'package:calendar_app/entity/date.dart';
import 'package:calendar_app/repository/calendar_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/provider/calendar_provider.g.dart';

@riverpod
class CalendarViewModel extends _$CalendarViewModel {
  final CalendarRepository _calendarRepository = CalendarRepository();

  @override
  Calendar build() {
    DateTime now = DateTime.now();
    List<Date> findByYearAndMonth =
        _calendarRepository.findByYearAndMonth(now.year, now.month);
    return Calendar(
        year: now.year,
        month: now.month,
        dateType: CalendarDateType.month,
        dates: findByYearAndMonth);
  }

  Future<void> findByMonth(int month) async {
    DateTime now = DateTime.now();
    List<Date> findByYearAndMonth =
        _calendarRepository.findByYearAndMonth(now.year, month);
    state = Calendar(
      year: now.year,
      month: month,
      dateType: CalendarDateType.month,
      dates: findByYearAndMonth,
    );
  }

  Future<void> findByYear(int year) async {
    List<Date> findByYear = _calendarRepository.findByYear(year);
    state = Calendar(
      year: year,
      dateType: CalendarDateType.year,
      dates: findByYear,
    );
  }

  Future<void> findByYearAndMonth(int year, int month) async {
    List<Date> findByYearAndMonth =
        _calendarRepository.findByYearAndMonth(year, month);
    state = Calendar(
      year: year,
      month: month,
      dateType: CalendarDateType.month,
      dates: findByYearAndMonth,
    );
  }

  Future<void> next() async {
    switch (state.dateType) {
      case CalendarDateType.year:
        List<Date> findByYear = _calendarRepository.findByYear(state.year + 1);
        state = Calendar(
          year: state.year + 1,
          dateType: CalendarDateType.year,
          dates: findByYear,
        );
      case CalendarDateType.month:
        DateTime dateTime = DateTime(state.year, state.month! + 1);
        List<Date> findByYearAndMonth = _calendarRepository.findByYearAndMonth(
            dateTime.year, dateTime.month);
        state = Calendar(
          year: dateTime.year,
          month: dateTime.month,
          dateType: CalendarDateType.month,
          dates: findByYearAndMonth,
        );
      case CalendarDateType.day:
        DateTime dateTime = DateTime(state.year, state.month!, state.day! + 1);
        List<Date> findByYearAndMonthAndDay =
            _calendarRepository.findByYearAndMonthAndDay(
          dateTime.year,
          dateTime.month,
          dateTime.day,
        );
        state = Calendar(
          year: dateTime.year,
          month: dateTime.month,
          day: dateTime.day,
          dateType: CalendarDateType.day,
          dates: findByYearAndMonthAndDay,
        );
    }
  }

  Future<void> prev() async {
    switch (state.dateType) {
      case CalendarDateType.year:
        List<Date> findByYear = _calendarRepository.findByYear(state.year - 1);
        state = Calendar(
          year: state.year + 1,
          dateType: CalendarDateType.year,
          dates: findByYear,
        );
      case CalendarDateType.month:
        DateTime dateTime = DateTime(state.year, state.month! - 1);
        List<Date> findByYearAndMonth = _calendarRepository.findByYearAndMonth(
            dateTime.year, dateTime.month);
        state = Calendar(
          year: dateTime.year,
          month: dateTime.month,
          dateType: CalendarDateType.month,
          dates: findByYearAndMonth,
        );
      case CalendarDateType.day:
        DateTime dateTime = DateTime(state.year, state.month!, state.day! - 1);
        List<Date> findByYearAndMonthAndDay =
        _calendarRepository.findByYearAndMonthAndDay(
          dateTime.year,
          dateTime.month,
          dateTime.day,
        );
        state = Calendar(
          year: dateTime.year,
          month: dateTime.month,
          day: dateTime.day,
          dateType: CalendarDateType.day,
          dates: findByYearAndMonthAndDay,
        );
    }
  }

}

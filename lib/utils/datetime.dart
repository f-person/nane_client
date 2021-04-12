bool areOnSameDay(DateTime? date1, DateTime? date2) {
  if (date1 == null || date2 == null) return false;

  return date1.day == date2.day &&
      date2.month == date2.month &&
      date1.year == date2.year;
}

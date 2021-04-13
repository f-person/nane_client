String? dateTimeToJson(DateTime? dateTime) {
  if (dateTime == null) return null;

  return dateTime.toUtc().toIso8601String();
}

DateTime? dateTimeFromJson(String? dateTime) {
  if (dateTime == null) return null;

  return DateTime.tryParse(dateTime)?.toLocal();
}

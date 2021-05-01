Uri getWebSocketUri({required String username}) {
  return Uri(
    scheme: 'wss',
    host: 'nane.tada.team',
    path: 'ws',
    queryParameters: {'username': username},
  );
}

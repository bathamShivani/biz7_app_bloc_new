class Bundle {
  final _map = <String, dynamic>{};

  T? get<T>(String key) {
    return _map[key] != null ? _map[key] as T : null;
  }

  void put<T>(String key, T value) {
    _map[key] = value;
  }

  int count() {
    return _map.length;
  }

  void clear() {
    _map.clear();
  }
}

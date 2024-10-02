
class SimpleCache
{

  static final SimpleCache _instance = SimpleCache._internal();

  SimpleCache._internal();

  factory SimpleCache()
  {
    return _instance;
  }

  final Map<String, dynamic> _cache = {};

  void setCache(String key, dynamic data)
  {
    _cache[key] = data;
  }

  dynamic getCache(String key)
  {
    return _cache[key];
  }

  bool containsKey(String key)
  {
    return _cache.containsKey(key);
  }

  void deleteData(String key)
  {
    _cache.remove(key);
  }

  void clearCache()
  {
    _cache.clear();
  }

}
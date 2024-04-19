class PBSingleton {
  static PBSingleton ? _pbSingleton;
  PBSingleton._();

  static Future <PBSingleton> instance() async {
    _pbSingleton ??= PBSingleton._();
    return _pbSingleton!;
  }
}
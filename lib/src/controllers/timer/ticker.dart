class Ticker {
  const Ticker();
  Stream<int> tick({required int maxTicks}) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (ticks) => ticks,
    ).take(maxTicks);
  }
}

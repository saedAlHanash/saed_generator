extension IterableExtensions<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E item) f) {
    var index = 0;
    return map((e) => f(index++, e));
  }
}

extension StringH on String {
  String get snakeToCamelCase {
    return split('_').mapIndexed((index, word) {
      if (index == 0) {
        return word.toLowerCase();
      } else {
        return word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
      }
    }).join();
  }

  String get convertToCamelCase {
    final words = split('_');
    return words.map((word) => word[0].toUpperCase() + word.substring(1)).join();
  }
}

extension IterableExtensions<E> on Iterable<E> {
  E? elementAtOrNull(int index) {
    return index >= length || index < 0 ? null : elementAt(index);
  }
}

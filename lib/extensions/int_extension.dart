extension IntExtension on int {
  String toHMString() {
    int h = this ~/ 60;
    int m = this - (this ~/ 60) * 60;
    if (h == 0) {
      return '$m分';
    } else if (m == 0) {
      return '$h時間';
    } else {
      return '$h時間：$m分';
    }
  }
}

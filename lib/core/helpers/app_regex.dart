/// app regular expration
class AppRegex {
  static RegExpMatch? isImageURLValid(String url) {
    return RegExp(
      r'(https?:\/\/)?([\w\-\.]+)\.[a-z]{2,}(\/\S*)?',
      caseSensitive: false,
    ).firstMatch(url);
  }
}

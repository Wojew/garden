class Validator {
  static bool isValid(String text) => text != null && text.trim().isNotEmpty;

  static bool areValid(List<String> texts) {
    if (texts == null || texts.isEmpty) {
      return false;
    }
    final notValidTexts = texts.where((text) => !isValid(text)).toList();
    return notValidTexts.isEmpty;
  }

  static bool atLeastOneValid(List<String> texts) => texts?.where(isValid)?.isNotEmpty ?? false;
}

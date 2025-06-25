class StringUtils {
  static Map<String, String> splitFullName(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return {'firstName': '', 'lastName': parts[0]};
    }
    final lastName = parts.last;
    final firstName = parts.sublist(0, parts.length - 1).join(' ');
    return {'firstName': firstName, 'lastName': lastName};
  }
}

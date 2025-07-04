/// Kiểm tra một chuỗi có phải là URL hợp lệ không
bool isValidUrl(String url) {
  try {
    final uri = Uri.parse(url);
    return uri.isAbsolute &&
        (uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https'));
  } catch (e) {
    return false;
  }
}

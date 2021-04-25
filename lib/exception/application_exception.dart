/// アプリケーション例外
/// アプリ内で独自に定義する例外はこの例外をextendsすることを推奨する
abstract class ApplicationException implements Exception {
  ApplicationException({
    this.code = '0',
    this.message = 'application exception',
    this.errorMessages = const [],
  }) : super();

  final String code;
  final String message;
  final List<String> errorMessages;

  @override
  String toString() {
    return "[$code] $message";
  }
}

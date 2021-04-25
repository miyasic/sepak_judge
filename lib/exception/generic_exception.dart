import 'application_exception.dart';

/// 汎用例外
class GenericException extends ApplicationException {
  GenericException({
    String code = '-1',
    String message = 'generic exception',
    List<String> errorMessages = const [],
  }) : super(
          code: code,
          message: message,
          errorMessages: errorMessages,
        );
}

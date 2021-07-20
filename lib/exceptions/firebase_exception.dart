class AuthException implements Exception {
  static const Map<String, String> errors = {
    "EMAIL_EXISTS": "Email Existe",
    "OPERATION_NOT_ALLOWED": "Operação não permitida",
    "TOO_MANY_ATTEMPTS_TRY_LATER": "Tente mais tarde",
    "EMAIL_NOT_FOUND": "Email não encontrado",
    "INVALID_PASSWORD": "Senha invalida",
    "USER_DISABLED": "Usuario desativado",
  };

  final String key;
  const AuthException(this.key);

  @override
  String toString() {
    if (errors.containsKey(key)) return errors[key]!;
    return "Ocorreu um erro";
  }
}

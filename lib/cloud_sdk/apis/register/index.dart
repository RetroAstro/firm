class RegisterErrorHandler {
  final Map<int, Function> handler = {};

  RegisterErrorHandler() {
    handler[202] = usernameError;
    handler[203] = emailError;
    handler[214] = mobileError;
  }

  void usernameError() {}
  void emailError() {}
  void mobileError() {}
}

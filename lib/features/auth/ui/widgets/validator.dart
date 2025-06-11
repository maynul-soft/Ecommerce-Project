String? validator(regExp, value, error) {


  if (!regExp.hasMatch(value!)) {
    return error;
  }
  return null;
}
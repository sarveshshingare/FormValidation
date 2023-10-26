bool validateEmailAddress(String input) {
  const emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  if (RegExp(emailRegex).hasMatch(input)) {
    return true;
  } else {
    return false;
  }
}
// njcndsjnvkds
bool validatePass(String input) {
  const passwordRegex = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';

  if (RegExp(passwordRegex).hasMatch(input)) {
    return true;
  } else {
    return false;
  }
}

bool validateName(String input) {
  // const nameRegex = r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]';
  const nameRegex = r'^[A-Za-z\s]+$';

  if (RegExp(nameRegex).hasMatch(input)) {
    return true;
  } else {
    return false;
  }
}

bool validateMobile(String input) {
  const mobileRegex = r'^(?:[+0][1-9])?[0-9]{10,12}$';

  if (RegExp(mobileRegex).hasMatch(input)) {
    return true;
  } else {
    return false;
  }
}

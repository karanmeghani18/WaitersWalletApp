String? validateEmail(String text){
  final String formattedText = text.trim();
  if(formattedText == ""){
    return "Please Enter Email";
  }
  final bool emailValid =
  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(formattedText);
  if(!emailValid){
    return "Please Enter Valid Email";
  }
  return null;
}

String? validatePassword(String text){
  final String formattedText = text.trim();
  if(formattedText == ""){
    return "Please Enter Password";
  }
  if(formattedText.length<8){
    return "Please Enter At Least 8 Characters Password";
  }
  if(formattedText.length>15){
    return "Please Enter At Most 15 Digit Password";
  }
  return null;
}

String? validateFullName(String text){
  final String formattedText = text.trim();
  if(formattedText == ""){
    return "Please enter your full name";
  }
  if(formattedText.length<3){
    return "Please enter at least 3 characters";
  }
  return null;
}
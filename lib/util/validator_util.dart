import 'package:get/get.dart';

Function validateUsername() {
  //GetUtils.isEmail()
  return (String? value) {
    if (value!.isEmpty) {
      return "유저네임에 들어갈 수 없습니다.";
    } else if (!GetUtils.isAlphabetOnly(value)) {
      return "유저네임에 한글이나 특수 문자가 들어갈 수 없습니다.";
    } else if (value.length > 12) {
      return "유저네임의 길이를 초과하였습니다.";
    } else if (value.length < 3) {
      return "유저네임의 최소 길이는 3자입니다.";
    } else {
      return null;
    }
  };
}

Function validatePhoneNumber() {
  //GetUtils.isEmail()
  return (String? value) {
    if (!GetUtils.isPhoneNumber(value!)) {
      return "휴대번호 형식에 알맞게 입력하세요.";
    } else {
      return null;
    }
  };
}

Function validateCode() {
  //GetUtils.isEmail()
  return (String? value) {
    if (!GetUtils.isNum(value!)) {
      return "숫자만 입력 할 수 있습니다.";
    }else if(!GetUtils.isLengthEqualTo(value, 6)) {
      return "코드는 6자리 입니다.";
    }
    else {
      return null;
    }
  };
}

Function validatePassword() {
  return (String? value) {
    if (value!.isEmpty) {
      return "패스워드 공백이 들어갈 수 없습니다.";
    } else if (value.length > 12) {
      return "패스워드의 길이를 초과하였습니다.";
    } else if (value.length < 6) {
      return "패스워드의 최소 길이는 6자입니다.";
    } else {
      return null;
    }
  };
}

Function validateEmail() {
  return (String? value) {
    if (value!.isEmpty) {
      return "이메일은 공백이 들어갈 수 없습니다.";
    } else if (!GetUtils.isEmail(value)) {
      return "이메일 형식에 맞지 않습니다.";
    } else {
      return null;
    }
  };
}

Function validateTitle() {
  return (String? value) {
    if (value!.isEmpty) {
      return "제목은 공백이 들어갈 수 없습니다.";
    } else if (value.length > 30) {
      return "제목의 길이를 초과하였습니다.";
    } else {
      return null;
    }
  };
}

Function validatePrice() {
  return (String? value) {
    bool check=false;
    try{
      int.parse(value!);
    }catch(e){
      check=true;
    }
    if (value!.isEmpty) {
      return "가격은 공백이 들어갈 수 없습니다.";
    } else if (check) {
      return "숫자만 들어갈 수 있습니다";
    } else {
      return null;
    }
  };
}

Function validateContent() {
  return (String? value) {
    if (value!.isEmpty) {
      return "내용은 공백이 들어갈 수 없습니다.";
    }
      return null;
  };
}

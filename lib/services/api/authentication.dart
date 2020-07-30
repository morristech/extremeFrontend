part of api;

class Authentication {
  static Future<Models.User> login({String email, String password}) async {
    try {
      var response = await dio
          .post('/auth/login', data: {"email": email, "password": password});

      var user = Models.User.fromJson(response.data);
      return user;
    } on DioError catch(e) {
      //обработка ошибочных кодов
      print(e.response.statusCode);
      return null;
    }
  }

  // dateBirthday в виде ДД.ММ.ГГГГ
  static Future<bool> signUp({String name, String email, String password, String dateBirthday, String phoneNumber, File avatar}) async {
    var form = FormData.fromMap({
      "name": name,
      "email": email,
      "password": password,
      "dateBirthday": dateBirthday,
      "phoneNumber": phoneNumber,
      "file": await MultipartFile.fromFile(
        avatar.path,
        filename: avatar.path.split('/').last,
      ),
    });

    try {
      var response = await dio.put('/auth/sugnUp', data: form);
      return true;
    } on DioError catch(e) {
      print(e.response.statusCode);
      return false;
    }
  }
}
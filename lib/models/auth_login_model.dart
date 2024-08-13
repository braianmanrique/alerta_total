class AuthLoginResponse {
    bool ok;
    String msg;
    User user;
    String token;

    AuthLoginResponse({
        required this.ok,
        required this.msg,
        required this.user,
        required this.token,
    });

    factory AuthLoginResponse.fromJson(Map<String, dynamic> json) {
    return AuthLoginResponse(
      ok: json['ok'],
      msg: json['msg'],
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }

}

class User {
    String name;
    String email;
    String document;
    String uid;

    User({
        required this.name,
        required this.email,
        required this.document,
        required this.uid,
    });

     factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      document: json['document'],
      uid: json['uid'],
    );
  }

}

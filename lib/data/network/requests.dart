class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
}


class RegisterRequest {
  String user_name;
  String country_mobile_code;
  String email;
  String password;
  String mobile_number;
  String profile_picture;

  RegisterRequest(this.user_name, this.country_mobile_code, this.email,
      this.password, this.mobile_number, this.profile_picture);
}

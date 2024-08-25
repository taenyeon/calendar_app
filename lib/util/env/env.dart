import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Env {
  // baseApi
  BASE_API_PATH('BASE_API_PATH'),

  // userApi
  USER_INFO_API('USER_INFO_API'),
  USER_JOIN_API('USER_JOIN_API'),
  USER_LOGIN_API('USER_LOGIN_API'),
  USER_LOGOUT_API('USER_LOGOUT_API'),
  USER_RE_ISSUE_ACCESS_TOKEN_API('USER_RE_ISSUE_ACCESS_TOKEN_API'),
  ;

  const Env(this.key);

  final String key;

  String get value => dotenv.get(key);
}

enum ErrorCase {
  unknown('UNKNOWN', '정의되지 않은 에러가 발생하였습니다.'),
  invalidToken('INVALID_TOKEN', '토큰이 유효하지 않습니다.'),
  wrongPassword('WRONG_PASSWORD', '비밀번호가 틀렸습니다.'),
  alreadyLogout('ALREADY_LOGOUT', '이미 로그아웃된 회원입니다.'),

  auth('AUTH', '권한이 없습니다.'),
  accessDenied('ACCESS_DENIED', '접근에 실패하였습니다.'),

  existMember('EXIST_MEMBER', '이미 존재하는 회원ID입니다.'),

  notFound('NOT_FOUND', '결과를 찾을 수 없습니다.'),
  invalidParam('INVALID_PARAM', '유효하지 않은 파라미터입니다.'),
  ;

  const ErrorCase(this.code, this.message);
  final String code;
  final String message;
}

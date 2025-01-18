/// api Url
class ApiUrls {
  static const String baseUrl = 'https://api.igdb.com/v4';
  static const String getGames = '/games';
}

class ApiErrors {
  static const String success = "Success";
  static const String badRequestError = "bad request. try again later";
  static const String noContent = "Success with not content";
  static const String forbiddenError = "forbidden request. try again later";
  static const String unauthorizedError = "user unauthorized, try again later";
  static const String notFoundError = "url not found, try again later";
  static const String conflictError = "conflict found, try again later";
  static const String internalServerError =
      "some thing went wrong, try again later";
  static const String unknownError = "some thing went wrong, try again later";
  static const String timeoutError = "time out, try again late";
  static const String defaultError = "some thing went wrong, try again later";
  static const String cacheError = "cache error, try again later";
  static const String noInternetError = "Please check your internet connection";
  static const String apiLogicError = "Something went wrong with the data sent";
  static const String loadingMessage = "Loading ... ";
  static const String retryAgainMessage = "Retry Again ";
  static const String ok = "Ok";
}

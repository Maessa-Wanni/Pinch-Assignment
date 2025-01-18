import 'package:dio/dio.dart';

import '../../../../core/networking/api_service.dart';
import '../../../../core/networking/api_urls.dart';

/// games service requests
class GamesWebService {
  final ApiService apiService;

  GamesWebService(this.apiService);

  Future<Response> getGamesData(int offset, {int? limit = 10}) async {
    final body = '''
    fields name, slug, age_ratings.rating, summary, storyline, screenshots.url, cover.url, alternative_names.name, age_ratings.*, websites.*, game_localizations.name;
    limit $limit;
    offset $offset;
  ''';
    var result = await apiService.post(
        endPoint: ApiUrls.getGames, auth: true, data: body);
    return result;
  }
}

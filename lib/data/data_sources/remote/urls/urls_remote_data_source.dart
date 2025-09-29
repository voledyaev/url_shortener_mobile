import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:url_shortener/data/data_sources/remote/urls/dtos/shorten_request_dto.dart';
import 'package:url_shortener/data/data_sources/remote/urls/dtos/shorten_response_dto.dart';
import 'package:url_shortener/data/data_sources/remote/urls/dtos/stats_response_dto.dart';

@singleton
class UrlsRemoteDataSource {
  UrlsRemoteDataSource(this._dio);

  final Dio _dio;

  static const _groupUrl = '/api/v1';

  Future<ShortenResponseDto> shortenUrl(ShortenRequestDto dto) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '$_groupUrl/shorten',
      data: dto.toJson(),
    );
    final result = ShortenResponseDto.fromJson(response.data!);
    return result;
  }

  Future<StatsResponseDto> getStats(String id) async {
    final response = await _dio.get<Map<String, dynamic>>('$_groupUrl/stats/$id');
    final result = StatsResponseDto.fromJson(response.data!);
    return result;
  }
}

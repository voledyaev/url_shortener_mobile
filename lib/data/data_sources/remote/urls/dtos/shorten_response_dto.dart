import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shorten_response_dto.g.dart';

@immutable
@JsonSerializable(createToJson: false)
class ShortenResponseDto {
  const ShortenResponseDto({
    required this.shortUrl,
    required this.expiresAt,
  });

  factory ShortenResponseDto.fromJson(Map<String, dynamic> json) => _$ShortenResponseDtoFromJson(json);

  final Uri shortUrl;
  final DateTime? expiresAt;
}

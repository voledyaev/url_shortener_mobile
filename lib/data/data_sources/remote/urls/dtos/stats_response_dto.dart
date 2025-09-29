import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stats_response_dto.g.dart';

@immutable
@JsonSerializable(createToJson: false)
class StatsResponseDto {
  const StatsResponseDto({
    required this.original,
    required this.createdAt,
    required this.expiresAt,
    required this.clicks,
  });

  factory StatsResponseDto.fromJson(Map<String, dynamic> json) => _$StatsResponseDtoFromJson(json);

  final Uri original;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final int clicks;
}

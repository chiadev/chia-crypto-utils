import 'package:meta/meta.dart';

@immutable
class ChiaBaseResponse {
  const ChiaBaseResponse({
    required this.error,
    required this.success,
  });
  factory ChiaBaseResponse.fromJson(Map<String, dynamic> json) {
    return ChiaBaseResponse(
      error: json['error'] as String?,
      success: json['success'] as bool,
    );
  }
  final String? error;
  final bool success;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'error': error,
        'success': success,
      };

  @override
  String toString() => 'ChiaBaseResponse(success: $success, error: $error)';
}

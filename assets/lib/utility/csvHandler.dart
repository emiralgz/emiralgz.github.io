import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:gezgin/utility/translator.dart';  // Import your translator service

class VideoItem {
  final String title;
  final String description;
  final String locationName;
  final double latitude;
  final double longitude;
  final String thumbnail;
  final String videoUrl;
  final DateTime publishedAt;

  VideoItem({
    required this.title,
    required this.description,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.thumbnail,
    required this.videoUrl,
    required this.publishedAt,
  });

  VideoItem copyWith({
    String? title,
    String? description,
    String? locationName,
    double? latitude,
    double? longitude,
    String? thumbnail,
    String? videoUrl,
    DateTime? publishedAt,
  }) {
    return VideoItem(
      title: title ?? this.title,
      description: description ?? this.description,
      locationName: locationName ?? this.locationName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      thumbnail: thumbnail ?? this.thumbnail,
      videoUrl: videoUrl ?? this.videoUrl,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }

  factory VideoItem.fromCsv(List<dynamic> row) {
    String safeString(int i) =>
        i < row.length && row[i].toString().trim().isNotEmpty
            ? row[i].toString().trim()
            : '';

    double safeDouble(String value, [double fallback = 0.0]) {
      try {
        return double.parse(value);
      } catch (_) {
        return fallback;
      }
    }

    DateTime safeDate(String value) {
      try {
        return DateTime.parse(value.trim()).toLocal();
      } catch (_) {
        return DateTime(1970);
      }
    }

    final coords = safeString(3).split(',');
    final lat = coords.length > 0 ? safeDouble(coords[0]) : 0.0;
    final lng = coords.length > 1 ? safeDouble(coords[1]) : 0.0;

    return VideoItem(
      title: safeString(0),
      description: safeString(1),
      locationName: safeString(2),
      latitude: lat,
      longitude: lng,
      thumbnail: safeString(4),
      videoUrl: safeString(5),
      publishedAt: safeDate(safeString(6)),
    );
  }
}

Future<List<VideoItem>> loadVideoItemsOriginal() async {
  final raw = await rootBundle.loadString('lib/assets/videoList.csv');
  final rows = const CsvToListConverter(eol: '\n').convert(raw);

  final items = rows
      .skip(1)
      .where((row) => row.isNotEmpty)
      .map((row) {
    try {
      return VideoItem.fromCsv(row);
    } catch (_) {
      return null;
    }
  })
      .whereType<VideoItem>()
      .toList();

  items.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  return items;
}
Future<List<VideoItem>> loadVideoItemsTranslated(String targetLangCode) async {
  final originalItems = await loadVideoItemsOriginal();

  final translatedItems = await Future.wait(originalItems.map((item) async {
    try {
      final translatedTitle = await TranslatorService.translateText(item.title, targetLangCode);
      final translatedLocationName = await TranslatorService.translateText(item.locationName, targetLangCode);
      final translatedDescription = await TranslatorService.translateText(item.description, targetLangCode);

      return item.copyWith(
        title: translatedTitle,
        locationName: translatedLocationName,
        description: translatedDescription,
      );
    } catch (_) {
      return item; // fallback to original if translation fails
    }
  }));

  translatedItems.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  return translatedItems;
}

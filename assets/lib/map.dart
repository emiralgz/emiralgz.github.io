import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';

import 'package:gezgin/utility/csvHandler.dart'; // your VideoItem import
import 'package:gezgin/utility/youtubePlayer.dart'; // YoutubePlayerWebViewAll widget
import 'package:gezgin/utility/stringDict.dart';

class VideoMap extends StatefulWidget {
  final String selectedLang;
  final bool isDarkMode;

  const VideoMap({
    Key? key,
    required this.isDarkMode,
    required this.selectedLang,
  }) : super(key: key);

  @override
  State<VideoMap> createState() => _VideoMapState();
}

class _VideoMapState extends State<VideoMap> {
  final PopupController _popupController = PopupController();

  late Future<List<VideoItem>> _videoItemsFuture;
  bool isTranslated = false;
  bool isTranslating = false;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() {
    setState(() {
      _videoItemsFuture = isTranslated
          ? loadVideoItemsTranslated(stringDict[widget.selectedLang]["code"])
          : loadVideoItemsOriginal();
    });
  }

  Future<void> _toggleTranslation() async {
    setState(() {
      isTranslating = true;
    });

    await Future.delayed(const Duration(milliseconds: 100));

    setState(() {
      isTranslated = !isTranslated;
      _loadItems();
      isTranslating = false;
    });
  }

  void _showVideoDialog(VideoItem video) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width * 0.6,
                          ),
                          child: YoutubePlayerWebViewAll(videoUrl: video.videoUrl)),
                      const SizedBox(height: 16),
                      SelectableText(
                        video.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SelectableText(
                            '${video.locationName} - ${DateFormat('MMMM d, y', stringDict[widget.selectedLang]["code"]).format(video.publishedAt)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SelectableText(
                        video.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 30,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showClusterDialog(List<VideoItem> clusteredVideos) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...clusteredVideos.map(
                        (video) => Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: MediaQuery.of(context).size.width * 0.6,
                                  ),
                                  child: YoutubePlayerWebViewAll(
                                    videoUrl: video.videoUrl,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SelectableText(
                                  video.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SelectableText(
                                      '${video.locationName} - ${DateFormat('MMMM d, y', stringDict[widget.selectedLang]["code"]).format(video.publishedAt)}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                SelectableText(
                                  video.description,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 30,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final langNameLower = widget.selectedLang.toLowerCase();

    return Scaffold(
      // No AppBar here
      body: FutureBuilder<List<VideoItem>>(
        future: _videoItemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Failed to load video items'));
          }

          final videoItems = snapshot.data!;

          final markers = videoItems.map((video) {
            return Marker(
              width: 40,
              height: 40,
              point: LatLng(video.latitude, video.longitude),
              child: GestureDetector(
                onTap: () => _showVideoDialog(video),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.deepPurple,
                  size: 40,
                ),
              ),
            );
          }).toList();

          return PopupScope(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(40.0647, 35),
                initialZoom: 4,
                maxZoom: 18,
                onTap: (_, __) => _popupController.hideAllPopups(),
              ),
              children: [
                TileLayer(
                  urlTemplate: (Theme.of(context).brightness == Brightness.dark)
                      ? 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png'
                      : 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.gezgin',
                ),
                MarkerClusterLayerWidget(
                  options: MarkerClusterLayerOptions(
                    maxClusterRadius: 120,
                    size: const Size(40, 40),
                    markers: markers,
                    polygonOptions: PolygonOptions(
                      borderColor: Colors.deepPurple,
                      color: Colors.blue.withOpacity(0.2),
                      borderStrokeWidth: 3,
                    ),
                    builder: (context, clusterMarkers) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          clusterMarkers.length.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                    onClusterTap: (cluster) {
                      final clusteredVideos = videoItems.where((video) {
                        return cluster.markers.any(
                          (marker) =>
                              marker.point.latitude == video.latitude &&
                              marker.point.longitude == video.longitude,
                        );
                      }).toList();

                      _showClusterDialog(clusteredVideos);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton: (langNameLower != 'türkçe')
          ? FloatingActionButton.extended(
              onPressed: isTranslating ? null : _toggleTranslation,
              label: isTranslating
                  ? Row(
                      children: const [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('Translating...'),
                      ],
                    )
                  : Text(
                      isTranslated
                          ? stringDict[widget.selectedLang]["originalLang"]
                          : stringDict[widget.selectedLang]["autotranslate"],
                    ),
              icon: isTranslating ? null : const Icon(Icons.translate),
            )
          : null,
    );
  }
}

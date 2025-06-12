import 'package:flutter/material.dart';
import 'package:webview_all/webview_all.dart';

class YoutubePlayerWebViewAll extends StatefulWidget {
  final String videoUrl;

  const YoutubePlayerWebViewAll({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<YoutubePlayerWebViewAll> createState() => _YoutubePlayerWebViewAllState();
}

class _YoutubePlayerWebViewAllState extends State<YoutubePlayerWebViewAll> {
  String? _extractVideoId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    if (uri.queryParameters.containsKey('v')) return uri.queryParameters['v'];
    if (uri.host.contains('youtu.be')) return uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : null;
    return null;
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    final videoId = _extractVideoId(widget.videoUrl);
    if (videoId == null) {
      return const Center(child: Text("Invalid YouTube URL"));
    }

    return ConstrainedBox(
        constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Webview(
          url:"https://www.youtube.com/embed/$videoId?rel=0&autoplay=0&modestbranding=1"
        ),
      ),
    );
  }
}

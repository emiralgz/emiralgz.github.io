import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:gezgin/utility/csvHandler.dart';
import 'package:gezgin/utility/stringDict.dart';
import 'package:gezgin/utility/youtubePlayer.dart';

class BlogBodyPage extends StatefulWidget {
  final String selectedLang;

  const BlogBodyPage({required this.selectedLang, super.key});

  @override
  State<BlogBodyPage> createState() => _BlogBodyPageState();
}

class _BlogBodyPageState extends State<BlogBodyPage> {
  late Future<List<VideoItem>> _videoItemsFuture;
  bool isTranslated = false;
  bool isTranslating = false;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  List<VideoItem> _allItems = [];
  List<VideoItem> _filteredItems = [];
  Map<int, GlobalKey> _itemKeys = {};

  // For overlay suggestions
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _loadItems();

    _searchController.addListener(() {
      final text = _searchController.text;
      _filterItems(text);
      if (text.isNotEmpty && _filteredItems.isNotEmpty) {
        _showOverlay();
      } else {
        _removeOverlay();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _loadItems() {
    setState(() {
      _videoItemsFuture = isTranslated
          ? loadVideoItemsTranslated(stringDict[widget.selectedLang]["code"])
          : loadVideoItemsOriginal();
      _videoItemsFuture.then((items) {
        setState(() {
          _allItems = items;
          _filteredItems = items;
          _itemKeys = {for (var i = 0; i < items.length; i++) i: GlobalKey()};
        });
      });
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

  void _filterItems(String query) {
    final filtered = _allItems.where((item) {
      final title = item.title.toLowerCase();
      final q = query.toLowerCase();
      return title.contains(q);
    }).toList();

    setState(() {
      _filteredItems = filtered;
    });
  }

  void _scrollToItem(int index) {
    final key = _itemKeys[index];
    if (key == null) return;

    final context = key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      alignment: 0.1,
    );
  }

  void _showOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _removeOverlay();
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Positioned(
                width: size.width,
                // match horizontal padding of search field
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: const Offset(0, 56), // position below TextField
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(10),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = _filteredItems[index];
                          return ListTile(
                            title: Text(item.title),
                            onTap: () {
                              final originalIndex = _allItems.indexOf(item);
                              _scrollToItem(originalIndex);
                              _removeOverlay();
                              _searchController.text = item.title;
                              _filterItems(item.title);
                              FocusScope.of(context).unfocus();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final langNameLower = widget.selectedLang.toLowerCase();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: CompositedTransformTarget(
                    link: _layerLink,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: stringDict[widget.selectedLang]["search"],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _filterItems('');
                            _removeOverlay();
                          },
                        )
                            : null,
                      ),
                      onSubmitted: (value) {
                        if (_filteredItems.isNotEmpty) {
                          final firstIndex = _allItems.indexOf(_filteredItems[0]);
                          _scrollToItem(firstIndex);
                          _removeOverlay();
                          FocusScope.of(context).unfocus();
                        }
                      },
                    ),
                  ),
                ),
                if (langNameLower != 'türkçe')
                  TextButton.icon(
                    onPressed: isTranslating ? null : _toggleTranslation,
                    icon: const Icon(Icons.translate),
                    label: Text(
                      isTranslating
                          ? stringDict[widget.selectedLang]["translating"]
                          : (isTranslated
                          ? stringDict[widget.selectedLang]["originalLang"]
                          : stringDict[widget.selectedLang]["autotranslate"]),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<VideoItem>>(
              future: _videoItemsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No blog entries found.'));
                } else {
                  final items = _filteredItems;
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final originalIndex = _allItems.indexOf(item);
                      return BlogEntry(
                        key: _itemKeys[originalIndex],
                        selectedLang: widget.selectedLang,
                        item: item,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );

  }
}

class BlogEntry extends StatefulWidget {
  final VideoItem item;
  final String selectedLang;

  const BlogEntry({super.key, required this.selectedLang, required this.item});

  @override
  State<BlogEntry> createState() => _BlogEntryState();
}

class _BlogEntryState extends State<BlogEntry> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: YoutubePlayerWebViewAll(videoUrl: widget.item.videoUrl),
            ),
            const SizedBox(height: 16),
            SelectableText(
              '${widget.item.title}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SelectableText(
                  '${widget.item.locationName} - ${DateFormat('MMMM d, y', stringDict[widget.selectedLang]["code"]).format(widget.item.publishedAt)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SelectableText(
              widget.item.description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

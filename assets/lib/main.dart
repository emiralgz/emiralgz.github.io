import 'package:flutter/material.dart';
import 'package:gezgin/utility/stringDict.dart';
import 'package:gezgin/about.dart';
import 'package:gezgin/blog.dart';
import 'package:gezgin/map.dart';
import 'package:gezgin/donate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.dark;
  String selectedLang = 'Türkçe';

  Page currentPage = Page.about;

  void setPage(Page page) {
    setState(() {
      currentPage = page;
    });
  }

  void toggleTheme() {
    setState(() {
      themeMode = themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  void changeLanguage(String lang) {
    setState(() {
      selectedLang = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale(stringDict[selectedLang]['code']),
      // use 'pl', 'en', etc. for other languages
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
        Locale('de'),
        Locale('es'),
        Locale('fr'),
        Locale('ar'),
        Locale('pt'),
        Locale('it'),
        Locale('ru'),
        Locale('zh'),
        Locale('ja'),
        Locale('ko'),
        Locale('hi'),
        Locale('bn'),
        Locale('pl'),
        Locale('sv'),
        Locale('nl'),
        Locale('th'),
        Locale('no'),


      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      title: stringDict[selectedLang]['title'],
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      home: HomePage(
        onSetPage: setPage,
        currentPage: currentPage,
        selectedLang: selectedLang,
        onChangeLang: changeLanguage,
        onToggleTheme: toggleTheme,
        isDarkMode: themeMode == ThemeMode.dark,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

enum Page { about, map, blog, donate }

class HomePage extends StatefulWidget {
  final Function(Page) onSetPage;
  final Page currentPage;
  final String selectedLang;
  final Function(String) onChangeLang;
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const HomePage({
    super.key,
    required this.onSetPage,
    required this.currentPage,
    required this.selectedLang,
    required this.onChangeLang,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final List<String> availableLanguages = stringDict.keys.toList();
    Widget bodyContent;

    switch (widget.currentPage) {
      case Page.about:
        bodyContent = AboutPage(selectedLang: widget.selectedLang);
        break;
      case Page.map:
        bodyContent = VideoMap(
          selectedLang: widget.selectedLang,
          isDarkMode: widget.isDarkMode,
        );
        break;
      case Page.blog:
        bodyContent = BlogBodyPage(selectedLang: widget.selectedLang);
        break;
      case Page.donate:
        bodyContent =  DonatePage(selectedLang: widget.selectedLang);
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              stringDict[widget.selectedLang]['title'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        actions: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: DropdownButton<String>(
                icon: SizedBox.shrink(),
                // Hides the down arrow
                underline: SizedBox.shrink(),
                // Removes underline
                alignment: Alignment.center,

                value: widget.selectedLang,
                onChanged: (value) {
                  if (value != null) widget.onChangeLang(value);
                },
                items: availableLanguages.map((language) {
                  return DropdownMenuItem<String>(
                    value: language,
                    child: Text(language),
                  );
                }).toList(),
              ),
            ),
          ),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Switch(
                  // This bool value toggles the switch.
                  value: widget.isDarkMode,
                  thumbIcon: WidgetStateProperty<Icon>.fromMap(
                    <WidgetStatesConstraint, Icon>{
                      WidgetState.selected: Icon(Icons.dark_mode),
                      WidgetState.any: Icon(Icons.light_mode),
                    },
                  ),
                  onChanged: (bool value) {
                    widget.onToggleTheme();
                  },
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => widget.onSetPage(Page.about),
                          child: Text(
                            stringDict[widget.selectedLang]['about']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => widget.onSetPage(Page.map),
                          child: Text(
                            stringDict[widget.selectedLang]['map']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => widget.onSetPage(Page.blog),
                          child: Text(
                            stringDict[widget.selectedLang]['blog']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => widget.onSetPage(Page.donate),
                          child: Text(
                            stringDict[widget.selectedLang]['donate']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: bodyContent,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

   Locale? _appLocale;

    Future <void> _changeLanguage(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', locale.languageCode);
    setState(() {
      _appLocale = locale;
    });
  }


  Future <void> _loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('language') ?? 'en';
    setState(() {
      _appLocale = Locale(languageCode);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,


      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],


      locale: _appLocale,
      supportedLocales: const [
        Locale('en'),
        Locale('bn'),
      ],
      home: HomePage(changeLanguage: _changeLanguage),
    );
  }
}

class HomePage extends StatefulWidget {
  final Function changeLanguage;

  const HomePage({Key? key, required this.changeLanguage});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appbar)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 60,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: () {

                    var locale = AppLocalizations.of(context)!.language == 'বাংলা' ? const Locale('bn') : const Locale('en');

                    widget.changeLanguage(locale);
                  },
                  child: Text(AppLocalizations.of(context)!.language)
              ),
            ],
          ),

          Text(AppLocalizations.of(context)!.bangladesh,style: const TextStyle(fontSize: 30),),

          const SizedBox(height: 30,),

          Text(AppLocalizations.of(context)!.bangladesh_history)

        ],
      ),
    );
    
  }
}
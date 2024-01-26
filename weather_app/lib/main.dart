import 'package:flutter/material.dart';
import 'package:weather_app/locale_provider.dart';
import 'package:weather_app/models.dart';
import 'package:weather_app/service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/all_locales.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<LocaleProvider>(
      create: (_) => LocaleProvider(),
      builder: (context, child) {
        return MaterialApp(
          title: 'Weather App',
          supportedLocales: AllLocales.all,
          locale: Provider.of<LocaleProvider>(context).locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: const MyHomePage(title: 'Weather App'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final cityTextController = TextEditingController();
  final dataService = DataService();

  WeatherResponse? _response;

  void search() async {
    final response = await dataService.getWeather(cityTextController.text, context);

    setState(() => _response = response);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Stack(
              children: <Widget>[
                Align(
                  alignment: const Alignment(-0.9, 0.9),
                  child: FloatingActionButton(
                    child: const Text("EN"),
                    onPressed: () => {
                      Provider.of<LocaleProvider>(context,listen: false).setLocale(AllLocales.all[0])
                    },
                  ),
                ),
                Align(
                  alignment: const Alignment(0.9, 0.9),
                  child: FloatingActionButton(
                    child: const Text("RU"),
                    onPressed: () => {
                      Provider.of<LocaleProvider>(context,listen: false).setLocale(AllLocales.all[1])
                    },
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_response != null)
                    Column(
                      children: [
                        Text(
                          cityTextController.text,
                          style: const TextStyle(fontSize: 30),
                        ),
                        Text(
                          '${_response!.tempInfo.temperature}°',
                          style: const TextStyle(fontSize: 40),
                        ),
                        Text(_response!.weatherInfo.description),
                        Image.network(_response!.iconUrl),
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: SizedBox(
                      width: 150,
                      child: TextField(
                          controller: cityTextController,
                          decoration: InputDecoration(labelText: AppLocalizations.of(context)!.city.toString()),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: search,
                      child: Text(AppLocalizations.of(context)!.search.toString())
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
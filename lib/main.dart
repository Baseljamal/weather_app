import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/views/home_view.dart';

void main() async{
  await dotenv.load(fileName: "key.env");
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: BlocBuilder<GetWeatherCubit, WeatherState>(
        builder: (context, state) {
          return CustomMaterialApp(
            condition: state is WeatherLoadedState
                ? state.weatherModel.condetion
                : null,
          );
        },
      ),
    );
  }
}

class CustomMaterialApp extends StatelessWidget {
  final String? condition;

  const CustomMaterialApp({super.key, this.condition});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: getThemeColor(condition),
          foregroundColor: Colors.white,
        ),
        primarySwatch: getThemeColor(condition),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}

MaterialColor getThemeColor(String? condition) {
  if (condition == null) {
    return Colors.blue;
  }
  switch (condition) {
    case 'Sunny':
    case 'Clear':
      return Colors.yellow;
    case 'Partly cloudy':
      return Colors.lightBlue;
    case 'Cloudy':
      return Colors.grey;
    case 'Overcast':
      return Colors.blueGrey;
    case 'Mist':
      return Colors.blue;
    case 'Patchy rain possible':
    case 'Patchy light rain':
    case 'Light rain shower':
      return Colors.blue;
    case 'Patchy snow possible':
    case 'Patchy light snow':
    case 'Light snow showers':
      return Colors.lightBlue;
    case 'Patchy sleet possible':
    case 'Light sleet':
    case 'Light sleet showers':
      return Colors.blueGrey;
    case 'Patchy freezing drizzle possible':
    case 'Freezing drizzle':
    case 'Freezing fog':
      return Colors.lightBlue;
    case 'Thundery outbreaks possible':
    case 'Patchy light rain with thunder':
      return Colors.purple;
    case 'Blowing snow':
    case 'Blizzard':
      return Colors.grey;
    case 'Fog':
      return Colors.grey;
    case 'Patchy light drizzle':
    case 'Light drizzle':
      return Colors.blue;
    case 'Heavy freezing drizzle':
    case 'Light freezing rain':
      return Colors.blueGrey;
    case 'Light rain':
    case 'Moderate rain at times':
      return Colors.blue;
    case 'Moderate rain':
    case 'Heavy rain at times':
    case 'Heavy rain':
      return Colors.blue;
    case 'Moderate or heavy freezing rain':
    case 'Moderate or heavy sleet':
    case 'Patchy heavy snow':
    case 'Heavy snow':
      return Colors.grey;
    case 'Ice pellets':
    case 'Light showers of ice pellets':
    case 'Moderate or heavy showers of ice pellets':
      return Colors.cyan;
    case 'Moderate or heavy rain shower':
    case 'Torrential rain shower':
      return Colors.blue;
    case 'Moderate or heavy rain with thunder':
    case 'Moderate or heavy snow with thunder':
      return Colors.purple;
    case 'Patchy light snow with thunder':
      return Colors.purple;
    default:
      return Colors.grey; // Default color for unknown conditions
  }
}

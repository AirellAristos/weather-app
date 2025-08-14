import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/config/theme/app_theme.dart';
import 'package:weatherapp/core/utils/greetings.dart';
import 'package:weatherapp/core/utils/time_converter.dart';
import 'package:weatherapp/viewmodels/state/forecast_state.dart';
import 'package:weatherapp/viewmodels/state/auth_state.dart';
import 'package:weatherapp/viewmodels/state/weather_screen_state.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(weatherScreenStateNotifierProvider.notifier).getWeatherData();
      ref.read(forecastStateNotifierProvider.notifier).getForecastData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(weatherScreenStateNotifierProvider);
    final forecastState = ref.watch(forecastStateNotifierProvider);
    final authState = ref.watch(authStateNotifierProvider);

    return Scaffold(
      body: Builder(
        builder: (_) {
          if (state.isLoading || forecastState.isLoading) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary
                  ],
                ),
              ),
              child: const Center(child:  CircularProgressIndicator())
          );
          } else if (state.response?.data != null && forecastState.response?.data != null) {
            final timezone = state.response?.data?.timezone;
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary
                  ],
                ),
              ),
              child: Stack(
                children:[
                  SafeArea(
                    child: Column(
                      children: [
                        //Sambutan
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: _welcomeMessage(context, state, authState),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                        //Weather & Location
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: _weatherAndLocation(context, state),
                        ),
                      ]
                    ),
                  ),
                  _fixedBottomBar(context, forecastState, timezone)
                ]
              )
            );
          } else {
            return const Center(child: Text('Tidak ada data'));
          }
        }
      ),
    );
  }

  Widget _welcomeMessage(BuildContext context, WeatherScreenState state, AuthState authState){
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${Greetings.getGreeting()}, ${(authState.user?.isEmpty ?? true) ? 'User' : authState.user!}\n',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 0.5,
                ),
              ),
              Text(
                  'Diperbarui Pada : ${state.response!.data!.dt != null && state.response!.data!.timezone != null
                      ? TimeConverter.toLocalHour(state.response!.data!.dt!, state.response!.data!.timezone!)
                      : '-'}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 20,
                  )
              ),
            ],
          ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              if(value == 'reload'){
                ref.read(weatherScreenStateNotifierProvider.notifier).getWeatherData();
                ref.read(forecastStateNotifierProvider.notifier).getForecastData();
              }else{
                ref.read(authStateNotifierProvider.notifier).logout();
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'reload',
                child: Text('Reload'),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
            child: const ElevatedButton(
              onPressed: null,
              child: Text('Menu'),
            ),
          )

        ],
      ),
    );
  }
  Widget _weatherAndLocation(BuildContext context, WeatherScreenState state) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            state.response?.data?.name ?? 'Tidak ada data Lokasi',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: FontSettings.fontSecondarySize,
            ),
          ),

          SizedBox(
            width: 120,
            height: 120,
            child: Image.network(
              state.response?.data?.weather?[0]?.icon != null
                  ? 'https://openweathermap.org/img/wn/${state.response!.data!.weather?[0]?.icon}@2x.png'
                  : 'https://openweathermap.org/img/wn/03d.png',
              fit: BoxFit.contain,
            ),
          ),
          Text(
            '${state.response?.data?.main?.temp?.toString() ?? "-"}°',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: FontSettings.fontMainSize,
            ),
          ),
          Text(
            state.response?.data?.weather?[0]?.description ?? 'Tidak ada data',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: FontSettings.fontSubContentSize,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'H: ${state.response?.data?.main?.tempMax ?? '-'}°',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: FontSettings.fontSubContentSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'L: ${state.response?.data?.main?.tempMin ?? '-'}°',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: FontSettings.fontSubContentSize,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  Widget _fixedBottomBar(BuildContext context, ForecastState state, int? timezone) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 100,
              height: 5,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Hourly Forecast',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: FontSettings.fontHeaderSize,
                ),
              )
            ),
            const SizedBox(height: 40),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: state.response?.data != null
                    ? state.response!.data!.list!.map((item) {
                    return Container(
                      width: 100,
                      height: MediaQuery.of(context).size.height * 0.2,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(10)
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(timezone != null && item?.dt != null
                              ?TimeConverter.toLocalHour(item!.dt!, timezone) :''
                          ),
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: Image.network(
                              item?.weather?[0]?.icon != null
                                  ? 'https://openweathermap.org/img/wn/${item?.weather?[0]?.icon}@2x.png'
                                  : 'https://openweathermap.org/img/wn/03d.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(item?.weather?[0]?.main ?? ''),
                          Text('${item?.main?.temp.toString() ?? ''}°'),
                        ],
                      )
                    );
                  }).toList()
                  : [const Center(child: Text('Tidak ada untuk cuaca beberapa jam kedepannya'))],
                )
              ),
            )
          ],
        )
      ),
    );
  }
}

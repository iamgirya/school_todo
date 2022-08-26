import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:school_todo/blocs/app_configuration/app_configuration_cubit.dart';
import 'package:school_todo/navigation/delegate.dart';
import 'package:school_todo/navigation/parser.dart';

import '../generated/l10n.dart';
import '../styles/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp(
      {Key? key,
      required this.importantColor,
      required this.delegate,
      required this.parser})
      : super(key: key);

  final Color importantColor;
  final ToDoRouterDelegate delegate;
  final ToDoRouteInformationParser parser;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double scale =
          constraints.maxWidth > 500 ? 0.5 + constraints.maxWidth / 1000 : 1;
      return BlocProvider<AppConfigurationCubit>(
        create: (context) {
          return AppConfigurationCubit(scale);
        },
        child: BlocBuilder<AppConfigurationCubit, AppConfigurationState>(
            builder: (context, state) {
          return FlavorBanner(
            location: BannerLocation.topEnd,
            child: MaterialApp.router(
              debugShowCheckedModeBanner:
                  FlavorConfig.instance.variables['isTestFlavor'],
              routerDelegate: delegate,
              routeInformationParser: parser,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: ThemeData.light().copyWith(
                extensions: <ThemeExtension<dynamic>>[
                  ToDoAppLightColors(
                    importantColor,
                  ),
                ],
              ),
              darkTheme: ThemeData.dark().copyWith(
                extensions: <ThemeExtension<dynamic>>[
                  ToDoAppDarkColors(
                    importantColor,
                  ),
                ],
              ),
              themeMode: (state as AppConfigurationLoadedState).isLightTheme
                  ? ThemeMode.light
                  : ThemeMode.dark,
            ),
          );
        }),
      );
    });
  }
}

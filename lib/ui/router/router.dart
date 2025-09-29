import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:url_shortener/ui/router/router.gr.dart';

@singleton
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MainRoute.page, initial: true),
    CustomRoute(
      page: ShortenUrlRoute.page,
      customRouteBuilder: <T>(context, child, page) => DialogRoute<T>(
        context: context,
        builder: (context) => child,
        settings: page,
      ),
    ),
    AutoRoute(page: StatsRoute.page),
  ];
}

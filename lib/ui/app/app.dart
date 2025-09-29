import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_shortener/di.dart';
import 'package:url_shortener/ui/app/app_view_model.dart';
import 'package:url_shortener/ui/common/view_model_provider.dart';
import 'package:url_shortener/ui/messenger/wrapper.dart';
import 'package:url_shortener/ui/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      create: (context) => getIt<AppViewModel>(),
      builder: (context, child) {
        final viewModel = context.read<AppViewModel>();

        return MaterialApp.router(
          title: 'URL Shortener',
          theme: theme,
          routerConfig: viewModel.routerConfig,
          builder: (context, child) => AppMessengerWrapper(
            stream: viewModel.messages,
            child: child!,
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

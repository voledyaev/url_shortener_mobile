import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_shortener/di.dart';
import 'package:url_shortener/ui/common/view_model_provider.dart';
import 'package:url_shortener/ui/pages/main/components/list.dart';
import 'package:url_shortener/ui/pages/main/main_page_view_model.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      create: (context) => getIt<MainPageViewModel>(),
      builder: (context, child) {
        final viewModel = context.read<MainPageViewModel>();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Your URLs'),
          ),
          body: const MainList(),
          floatingActionButton: FloatingActionButton(
            onPressed: viewModel.onAddPressed,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

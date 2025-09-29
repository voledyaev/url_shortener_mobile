import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_shortener/ui/pages/main/components/tile.dart';
import 'package:url_shortener/ui/pages/main/main_page_view_model.dart';

class MainList extends StatelessWidget {
  const MainList({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MainPageViewModel>();

    return ValueListenableBuilder(
      valueListenable: viewModel.state,
      builder: (context, value, child) {
        switch (value) {
          case null:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case []:
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 16,
                children: [
                  Icon(
                    Icons.add_to_queue_outlined,
                    size: 128,
                    color: ColorScheme.of(context).primary,
                  ),
                  const Text('Empty'),
                ],
              ),
            );

          default:
            return ListView.builder(
              itemBuilder: (context, index) => MainTile(url: value[index]),
              itemCount: value.length,
            );
        }
      },
    );
  }
}

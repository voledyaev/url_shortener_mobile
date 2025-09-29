import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_shortener/data/repositories/urls/models/url_model.dart';
import 'package:url_shortener/di.dart';
import 'package:url_shortener/ui/common/view_model_provider.dart';
import 'package:url_shortener/ui/pages/stats/stats_page_view_model.dart';

@RoutePage()
class StatsPage extends StatelessWidget {
  const StatsPage({
    super.key,
    required this.url,
  });

  final UrlModel url;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      create: (context) => getIt<StatsPageViewModel>(param1: url),
      builder: (context, child) {
        final viewModel = context.read<StatsPageViewModel>();

        return Scaffold(
          appBar: AppBar(
            title: const Text('URL stats'),
          ),
          body: ValueListenableBuilder(
            valueListenable: viewModel.state,
            builder: (context, value, child) {
              switch (value) {
                case null:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                default:
                  final formatter = DateFormat.yMMMMd().add_Hms();

                  final expiresAtTime = value.expiresAt;
                  Widget? expiresAt;
                  if (expiresAtTime != null) {
                    expiresAt = ListTile(
                      title: const Text('Expires At'),
                      subtitle: Text(formatter.format(expiresAtTime)),
                    );
                  }

                  return CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate.fixed([
                          ListTile(
                            onTap: viewModel.onUrlTap,
                            title: const Text('Short URL'),
                            subtitle: Text('${value.shortUrl}'),
                            trailing: const Icon(Icons.copy),
                          ),
                          ListTile(
                            title: const Text('Original URL'),
                            subtitle: Text('${value.original}'),
                          ),
                          ListTile(
                            title: const Text('Created At'),
                            subtitle: Text(formatter.format(value.createdAt)),
                          ),
                          ?expiresAt,
                          ListTile(
                            title: const Text('Clicked'),
                            subtitle: Text('${value.clicks} times'),
                          ),
                        ]),
                      ),
                      child!,
                    ],
                  );
              }
            },
            child: SliverToBoxAdapter(
              child: Center(
                child: ElevatedButton(
                  onPressed: viewModel.onOpenPressed,
                  child: const Text('Open'),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

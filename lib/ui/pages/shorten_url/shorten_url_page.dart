import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_shortener/di.dart';
import 'package:url_shortener/ui/common/view_model_provider.dart';
import 'package:url_shortener/ui/pages/shorten_url/shorten_url_page_view_model.dart';

@RoutePage()
class ShortenUrlPage extends StatefulWidget {
  const ShortenUrlPage({super.key});

  @override
  State<ShortenUrlPage> createState() => _ShortenUrlPageState();
}

class _ShortenUrlPageState extends State<ShortenUrlPage> {
  final _urlController = TextEditingController();
  final _ttlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    _ttlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      create: (context) => getIt<ShortenUrlPageViewModel>(),
      builder: (context, child) {
        final viewModel = context.read<ShortenUrlPageViewModel>();

        return AlertDialog(
          title: const Text('Enter Your URL'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              TextField(
                controller: _urlController,
                decoration: const InputDecoration(hintText: 'Your URL'),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.next,
              ),
              TextField(
                controller: _ttlController,
                decoration: const InputDecoration(hintText: 'TTL in seconds'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: viewModel.onCancelPressed,
              child: const Text('Cancel'),
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () => viewModel.onSubmitPressed(
                _urlController.text,
                _ttlController.text,
              ),
            ),
          ],
        );
      },
    );
  }
}

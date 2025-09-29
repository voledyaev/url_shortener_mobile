import 'package:injectable/injectable.dart';
import 'package:url_shortener/ui/common/view_model.dart';
import 'package:url_shortener/ui/router/router.dart';

@injectable
class ShortenUrlPageViewModel extends ViewModel {
  ShortenUrlPageViewModel(this._router);

  final AppRouter _router;

  void onCancelPressed() => _router.pop();

  void onSubmitPressed(String url, String ttl) {
    var parsedUrl = Uri.tryParse(url);

    if (parsedUrl == null) {
      _router.pop();
      return;
    }

    if (parsedUrl.path.isNotEmpty) {
      parsedUrl = Uri.https(
        parsedUrl.host,
        parsedUrl.path,
      );
    }

    if (parsedUrl.queryParameters.isNotEmpty) {
      parsedUrl = Uri.https(
        parsedUrl.host,
        parsedUrl.path,
        parsedUrl.queryParameters,
      );
    }

    final parsedTtl = int.tryParse(ttl);

    _router.pop<(Uri, int?)>((parsedUrl, parsedTtl));
  }
}

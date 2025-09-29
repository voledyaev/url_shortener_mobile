import 'package:provider/provider.dart';
import 'package:url_shortener/ui/common/view_model.dart';

class ViewModelProvider<T extends ViewModel> extends Provider<T> {
  ViewModelProvider({
    super.key,
    required super.create,
    super.builder,
    super.child,
  }) : super(
         dispose: (context, value) {
           value.dispose();
         },
         lazy: false,
       );

  ViewModelProvider.value({
    super.key,
    required super.value,
    super.builder,
    super.child,
  }) : super.value();
}

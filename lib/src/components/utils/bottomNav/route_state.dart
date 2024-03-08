import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/src/components/utils/bottomNav/persistent_tab_view.dart';

final routeStateProvider = ChangeNotifierProvider.autoDispose((ref) {
  return PersistentTabController(initialIndex: 0);
});

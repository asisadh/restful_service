import 'package:flutter_test/flutter_test.dart';
import 'package:restful_service/features/book/presentation/book_ui.dart';
import 'package:restful_service/routes.dart';

import 'utils/widgets.dart';

void main() {
  testWidgets(
    'shows error page when route is not found',
    (tester) async {
      await tester.pumpWidget(buildWidget(BookUI()));

      router.open('/non-existent');
      await tester.pumpAndSettle();

      expect(find.byType(Page404), findsOneWidget);
    },
  );
}

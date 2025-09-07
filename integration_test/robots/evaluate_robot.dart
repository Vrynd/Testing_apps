import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class EvaluateRobot {
  final WidgetTester tester;
  const EvaluateRobot(this.tester);

  final formulaFieldKey = const ValueKey("formulaField");
  final actionButtonKey = const ValueKey("actionButton");
  final resultKey = const ValueKey("result");

  // Load UI
  Future<void> loadUI(Widget widget) async {
    await tester.pumpWidget(widget);
  }

  // Interactions
  Future<void> typeFormula(String formula) async {
    final formulaFieldFinder = find.byKey(formulaFieldKey);
    await tester.tap(formulaFieldFinder);
    await tester.enterText(formulaFieldFinder, formula);
    await tester.testTextInput.receiveAction(TextInputAction.done);
  }

  // Tap Button
  Future<void> tapButton() async {
    final actionButtonFinder = find.byKey(actionButtonKey);
    await tester.tap(actionButtonFinder);
    await tester.pump();
  }

  // Result
  Future<void> checkResultText(String result) async {
    final resultFinder = find.byKey(resultKey);
    final resultWidget = tester.widget<Text>(resultFinder);
    expect(resultWidget.data, result);
  }
}

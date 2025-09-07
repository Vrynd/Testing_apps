import 'package:calculator_app/calculator_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'robots/evaluate_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("integrate all feature", (tester) async {
    final evaluateRobot = EvaluateRobot(tester);

    // load ui
    await evaluateRobot.loadUI(const CalculatorApp());

    // mengetik formula yang benar dan menjalankannya
    await evaluateRobot.typeFormula("3*25");
    await evaluateRobot.tapButton();
    await evaluateRobot.checkResultText("75.0");
  });
}

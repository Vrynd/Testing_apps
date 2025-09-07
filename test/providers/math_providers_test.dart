import 'package:calculator_app/providers/math_provider.dart';
import 'package:calculator_app/services/math_expression.dart';
import 'package:calculator_app/static/evaluate_formula_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockMathExpression extends Mock implements MathExpression {}

void main() {
  late MockMathExpression mathExpression;
  late MathProvider mathProvider;
  const String successFormula = "3*25";
  const String failedFormula = "math";
  const String resultOfSuccess = "75.0";
  const String resultOfFailed = "Cannot evaluate that formula.";

  setUp(() {
    mathExpression = MockMathExpression();
    mathProvider = MathProvider(mathExpression);
  });

  group("Math Provider", () {
    test('should return null when provider initialize.', () {
      final initState = mathProvider.state;

      expect(initState, null);
    });

    // Success Formula
    test('should return SuccessEvaluate type when formula is right.', () async {
      when(() => mathExpression.evaluate(successFormula))
          .thenReturn(resultOfSuccess);

      mathProvider.evaluate(successFormula);
      final state = mathProvider.state;

      expect(state, isA<SuccessEvaluate>());
    });

    test('should return 75 when formula is right.', () async {
      when(() => mathExpression.evaluate(successFormula))
          .thenReturn(resultOfSuccess);

      mathProvider.evaluate(successFormula);
      final state = mathProvider.state;

      expect(state, equals(SuccessEvaluate(resultOfSuccess)));
    });

    // Failed Formula
    test('should return FailedEvaluate type when formula is wrong.', () {
      when(() => mathExpression.evaluate(failedFormula))
          .thenThrow(resultOfFailed);

      mathProvider.evaluate(failedFormula);

      final state = mathProvider.state;
      expect(state, isA<FailedEvaluate>());
    });

    test(
        'should return "Cannot evaluate that formula." Error when formula is wrong.',
        () {
      when(() => mathExpression.evaluate(failedFormula))
          .thenThrow(resultOfFailed);

      mathProvider.evaluate(failedFormula);

      final state = mathProvider.state;
      expect(state, FailedEvaluate(resultOfFailed));
    });
  });
}

import 'package:curimba/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    group('validateBySize', () {
      test('should return error if value < size', () {
        expect(Validators.validateBySize("brand", 6), "Campo deve ter no mínimo 6 caracteres");
      });
      test('should return null if value >= size', () {
        expect(Validators.validateBySize("brand", 5), null);
        expect(Validators.validateBySize("brand", 4), null);
      });
    });
    group('validateNotEmpty', () {
      test('should return error if empty', () {
        expect(Validators.validateNotEmpty(""), 'Complete o campo');
      });
      test('should return null if not empty', () {
        expect(Validators.validateNotEmpty("brand"), null);
      });
    });
    group('validateDay', () {
      test('should return error if empty', () {
        expect(Validators.validateDay(""), 'Complete o campo');
      });
      test('should return error if day not valid', () {
        expect(Validators.validateDay("0"), 'Dia inválido');
        expect(Validators.validateDay("32"), 'Dia inválido');
      });
      test('should return null if day valid', () {
        expect(Validators.validateDay("1"), null);
      });
    });
    group('validateMonth', () {
      test('should return error if empty', () {
        expect(Validators.validateMonth(""), 'Complete o campo');
      });
      test('should return error if month not valid', () {
        expect(Validators.validateMonth("0"), 'Mês inválido');
        expect(Validators.validateMonth("13"), 'Mês inválido');
      });
      test('should return null if month valid', () {
        expect(Validators.validateMonth("1"), null);
      });
    });
    group('validateYear', () {
      test('should return error if empty', () {
        expect(Validators.validateYear(""), 'Complete o campo');
      });
      test('should return error if year not valid', () {
        expect(Validators.validateYear("1"), 'Ano inválido');
        expect(Validators.validateYear("12"), 'Ano inválido');
        expect(Validators.validateYear("123"), 'Ano inválido');
      });
      test('should return null if year valid', () {
        expect(Validators.validateYear("1234"), null);
      });
    });
    group('validateMonthYear', () {
      test('should return error if empty', () {
        expect(Validators.validateMonthYear(""), 'Complete o campo');
      });
      test('should return error if month not valid', () {
        expect(Validators.validateMonthYear("00/1234"), 'Mês inválido');
      });
      test('should return error if year not valid', () {
        expect(Validators.validateMonthYear("12/0"), 'Ano inválido');
      });
      test('should return error if year is empty', () {
        expect(Validators.validateMonthYear("12/"), 'Complete o campo');
      });
      test('should return null if month and year are valid', () {
        expect(Validators.validateMonthYear("12/1234"), null);
      });
    });
    group('validateLastNumbers', () {
      test('should return error if empty', () {
        expect(Validators.validateLastNumbers(""), 'Campo deve ter no mínimo 4 caracteres');
      });
      test('should return error if last numbers size < 4', () {
        expect(Validators.validateLastNumbers("•••• •••• •••• 12"),
            'Campo deve ter no mínimo 4 caracteres');
      });
      test('should return null if last numbers valid', () {
        expect(Validators.validateLastNumbers("•••• •••• •••• 1234"), null);
      });
    });
  });
}

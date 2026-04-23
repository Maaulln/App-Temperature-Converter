import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:temperatureconverter/domain/usecases/convert_temperature_usecase.dart';
import 'package:temperatureconverter/presentation/bloc/temperature_converter_bloc.dart';
import 'package:temperatureconverter/presentation/pages/temperature_converter_page.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => TemperatureConverterBloc(ConvertTemperatureUseCase()),
        child: const TemperatureConverterPage(),
      ),
    );
  }

  testWidgets('shows converted result after tapping Konversi', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(TextField), '100');
    await tester.tap(find.text('Konversi'));
    await tester.pump();

    expect(find.text('100.00 °C = 212.00 °F'), findsOneWidget);
  });

  testWidgets('shows validation error for invalid input', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(TextField), 'abc');
    await tester.tap(find.text('Konversi'));
    await tester.pump();

    expect(find.text('Masukkan angka yang valid'), findsOneWidget);
  });

  testWidgets('swap button swaps selected units', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byTooltip('Tukar satuan'));
    await tester.pump();

    await tester.enterText(find.byType(TextField), '100');
    await tester.tap(find.text('Konversi'));
    await tester.pump();

    expect(find.text('100.00 °F = 37.78 °C'), findsOneWidget);
  });
}

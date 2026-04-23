import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:temperatureconverter/domain/usecases/convert_temperature_usecase.dart';
import 'package:temperatureconverter/my_app.dart';
import 'package:temperatureconverter/presentation/bloc/temperature_converter_bloc.dart';

void main() {
  testWidgets('renders temperature converter title', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => TemperatureConverterBloc(ConvertTemperatureUseCase()),
        child: const MyApp(),
      ),
    );

    expect(find.text('Temperature Converter'), findsOneWidget);
  });
}

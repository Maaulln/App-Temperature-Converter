import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/usecases/convert_temperature_usecase.dart';
import 'presentation/bloc/temperature_converter_bloc.dart';
import 'my_app.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => TemperatureConverterBloc(ConvertTemperatureUseCase()),
      child: const MyApp(),
    ),
  );
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/temperature_unit.dart';
import '../../domain/usecases/convert_temperature_usecase.dart';

part 'temperature_converter_event.dart';
part 'temperature_converter_state.dart';

class TemperatureConverterBloc
    extends Bloc<TemperatureConverterEvent, TemperatureConverterState> {
  TemperatureConverterBloc(this._convertTemperature)
    : super(const TemperatureConverterState()) {
    on<TemperatureInputChanged>(_onTemperatureInputChanged);
    on<FromUnitChanged>(_onFromUnitChanged);
    on<ToUnitChanged>(_onToUnitChanged);
    on<SwapUnitsRequested>(_onSwapUnitsRequested);
    on<ConvertRequested>(_onConvertRequested);
  }

  final ConvertTemperatureUseCase _convertTemperature;

  void _onTemperatureInputChanged(
    TemperatureInputChanged event,
    Emitter<TemperatureConverterState> emit,
  ) {
    emit(
      state.copyWith(
        input: event.input,
        status: TemperatureConverterStatus.ready,
        clearError: true,
      ),
    );
  }

  void _onFromUnitChanged(
    FromUnitChanged event,
    Emitter<TemperatureConverterState> emit,
  ) {
    emit(
      state.copyWith(
        fromUnit: event.unit,
        status: TemperatureConverterStatus.ready,
        clearError: true,
      ),
    );
  }

  void _onToUnitChanged(
    ToUnitChanged event,
    Emitter<TemperatureConverterState> emit,
  ) {
    emit(
      state.copyWith(
        toUnit: event.unit,
        status: TemperatureConverterStatus.ready,
        clearError: true,
      ),
    );
  }

  void _onSwapUnitsRequested(
    SwapUnitsRequested event,
    Emitter<TemperatureConverterState> emit,
  ) {
    emit(
      state.copyWith(
        fromUnit: state.toUnit,
        toUnit: state.fromUnit,
        status: TemperatureConverterStatus.ready,
        clearError: true,
      ),
    );
  }

  void _onConvertRequested(
    ConvertRequested event,
    Emitter<TemperatureConverterState> emit,
  ) {
    final parsedValue = double.tryParse(state.input.trim());
    if (parsedValue == null) {
      emit(
        state.copyWith(
          status: TemperatureConverterStatus.error,
          errorMessage: 'Masukkan angka yang valid',
          result: '',
        ),
      );
      return;
    }

    final convertedValue = _convertTemperature(
      parsedValue,
      state.fromUnit,
      state.toUnit,
    );

    final resultText =
        '${parsedValue.toStringAsFixed(2)} ${state.fromUnit.symbol} = '
        '${convertedValue.toStringAsFixed(2)} ${state.toUnit.symbol}';

    emit(
      state.copyWith(
        status: TemperatureConverterStatus.success,
        result: resultText,
        clearError: true,
      ),
    );
  }
}

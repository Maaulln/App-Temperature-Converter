part of 'temperature_converter_bloc.dart';

sealed class TemperatureConverterEvent extends Equatable {
  const TemperatureConverterEvent();

  @override
  List<Object?> get props => [];
}

final class TemperatureInputChanged extends TemperatureConverterEvent {
  const TemperatureInputChanged(this.input);

  final String input;

  @override
  List<Object?> get props => [input];
}

final class FromUnitChanged extends TemperatureConverterEvent {
  const FromUnitChanged(this.unit);

  final TemperatureUnit unit;

  @override
  List<Object?> get props => [unit];
}

final class ToUnitChanged extends TemperatureConverterEvent {
  const ToUnitChanged(this.unit);

  final TemperatureUnit unit;

  @override
  List<Object?> get props => [unit];
}

final class SwapUnitsRequested extends TemperatureConverterEvent {
  const SwapUnitsRequested();
}

final class ConvertRequested extends TemperatureConverterEvent {
  const ConvertRequested();
}

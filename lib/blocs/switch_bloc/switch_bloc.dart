import 'package:equatable/equatable.dart';
import 'package:todo_bloc2/blocs/bloc_exports.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends HydratedBloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(const SwitchInitial()) {
    on<switchOnEvent>((event, emit) {
      emit(const SwitchState(switchValue: true));
    });
    on<switchOffEvent>((event, emit) {
      emit(const SwitchState(switchValue: false));
    });
  }

  @override
  SwitchState? fromJson(Map<String, dynamic> json) {
    return SwitchState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SwitchState state) {
    return state.toMap();
  }
}

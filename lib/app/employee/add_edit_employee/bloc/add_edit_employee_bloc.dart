import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_edit_employee_event.dart';
part 'add_edit_employee_state.dart';

class AddEditEmployeeBloc
    extends Bloc<AddEditEmployeeEvent, AddEditEmployeeState> {
  AddEditEmployeeBloc() : super(AddEditEmployeeInitial()) {
    on<AddEditEmployeeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

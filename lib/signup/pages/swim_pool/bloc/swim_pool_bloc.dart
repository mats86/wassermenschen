import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;
import 'package:wassermenschen/signup/pages/swim_pool/models/models.dart';

import '../../../../logic/models/models.dart';
import '../../../../logic/models/AppConfig.dart';

part 'swim_pool_event.dart';
part 'swim_pool_state.dart';
part 'swim_pool_service.dart';

class SwimPoolBloc extends Bloc<SwimPoolEvent, SwimPoolState> {
  final SwimPoolService _service;

  SwimPoolBloc(this._service) : super(const SwimPoolState()) {
    on<LoadSwimPools>(_onLoadSwimPools);
    on<SwimPoolOptionToggled>(_onSwimPoolOptionToggled);
    on<SwimPoolModelsChanged>(_onSwimPoolModelsChanged);
  }

  void _onLoadSwimPools(
    LoadSwimPools event,
    Emitter<SwimPoolState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: FormzStatus.submissionInProgress));
    try {
      var pools = await _service.getSwimPools();
      emit(state.copyWith(
          swimPools: pools, loadingStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(loadingStatus: FormzStatus.submissionFailure));
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _onSwimPoolOptionToggled(
    SwimPoolOptionToggled event,
    Emitter<SwimPoolState> emit,
  ) {
    var newPools = List<SwimPools>.from(state.swimPools);
    var pool = newPools[event.index];
    newPools[event.index] = SwimPools(pool.schwimmbadID, pool.name,
        pool.address, pool.phoneNumber, pool.openingTime, event.isSelected);
    final status = Formz.validate([SwimPoolModels.dirty(newPools)]);
    emit(state.copyWith(swimPools: newPools, toggleStatus: status));
  }

  void _onSwimPoolModelsChanged(
    SwimPoolModelsChanged event,
    Emitter<SwimPoolState> emit,
  ) {
    final swimPoolModels = SwimPoolModels.dirty(event.swimPools);
    emit(state.copyWith(
      swimPoolModels: swimPoolModels,
      toggleStatus: Formz.validate([swimPoolModels]),
    ));
  }
}

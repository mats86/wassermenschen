import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;

import '../../../../logic/models/AppConfig.dart';
import '../../../../logic/models/models.dart';

part 'swim_course_event.dart';
part 'swim_course_state.dart';

class SwimCourseBloc extends Bloc<SwimCourseEvent, SwimCourseState> {
  SwimCourseBloc({required userRepository}) : super(const SwimCourseState());

  void loadSwimCourseOptions() async {
    try {
      final response = await http.get(
        Uri.parse('${AppConfig.serverUrl}/getSwimCourse'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*', // Erlaubt Anfragen von allen Domänen
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['swim_courses'];

        final swimCourseOptions = List<SwimCourse>.from(data.map((item) => SwimCourse(
          item['KursID'],
          item['Name'],
          item['Preis'],
          item['Beschreibung'],
          item['HatFixtermine'],
          item['Altersgruppe'],
          item['KursDauer'],
        )));
        //Refresh the UI with fetched data
        emit(state.copyWith(swimCourseOptions: swimCourseOptions));
      } else {
        // Handle other status codes or errors
        print('Error while fetching data: ${response.statusCode}');
        throw Exception('Failed to fetch swim courses'); // Hier wird eine Ausnahme geworfen
      }
    } catch (e) {
      throw Exception('Failed to fetch swim courses'); // Hier wird eine Ausnahme geworfen
    }
  }

  void updateSwimCourse(String swimCourse) {
    emit(state.copyWith(swimCourse: swimCourse));
  }
}
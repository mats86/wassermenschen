part of 'swim_course_bloc.dart';

class SwimCourseService {
  Future<List<String>> _fetchSwimSeason() async {
    return <String>['Laufender Sommer', 'Kommender Sommer'];
  }

  Future<List<SwimCourse>> _fetchSwimCourses() async {
    final response = await http.get(
      Uri.parse('${AppConfig.serverUrl}/getSwimCourse'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['swim_courses'];
      return data.map((item) => SwimCourse.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load swim courses');
    }
  }

}

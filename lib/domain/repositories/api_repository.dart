abstract class ApiRepository {
  Future<Map<String, dynamic>> login(String email, String password);
}

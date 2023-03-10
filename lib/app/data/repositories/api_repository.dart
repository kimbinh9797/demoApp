import 'package:todo_application/app/services/s_sqlite.dart';

class ApiRepository {
  Future<Map<String, dynamic>> login(String email, String password) async {
    SqliteServices sqliteServices = SqliteServices();
    final res = await sqliteServices.getUser(email, password);
    if (res != null) {
      return {
        "status": "Success",
        "token":
            "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiS2ltIEJpbmgiLCJlbWFpbCI6ImJpbmhAZ21haWwuY29tIiwicGFzc3dvcmQiOiJCaW5oMTIzNCJ9.d1thzqNlWDRYILFTnBA-x8BIldeV31Gk56Os5_U6MP4"
      };
    } else {
      return {"status": "Failed"};
    }
  }
}

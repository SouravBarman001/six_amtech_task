part of 'rest_client.dart';

//PUBLIC => Generic API url without access token
//PROTECTED => Generic API url with access token
enum APIType { public, protected }

abstract class ApiOptions {
  Options options = Options();
}

class PublicApiOptions extends ApiOptions {
  PublicApiOptions() {
    super.options.headers = <String, dynamic>{
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'zoneId': '[1]',
      'latitude': '23.735129',
      'longitude': '90.425614',
    };
  }
}

class ProtectedApiOptions extends ApiOptions {
  ProtectedApiOptions(String apiToken) {
    super.options.headers = <String, dynamic>{
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $apiToken',
      'zoneId': '[1]',
      'latitude': '23.735129',
      'longitude': '90.425614',
    };
  }
}

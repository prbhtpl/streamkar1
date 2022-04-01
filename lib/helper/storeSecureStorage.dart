import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage{
static final _storage=FlutterSecureStorage();
static const _keyusername='username';
static const _password='password';
static Future setUserName(String username)async{
  await _storage.write(key: _keyusername, value: username);
}
static Future setPassword(String password)async{
  await _storage.write(key: _password, value: password);
}
static Future<String?> getUsername()async{
  await _storage.read(key: _keyusername);
}
static Future<String?> getPassword()async{
  await _storage.read(key: _password);
}

}
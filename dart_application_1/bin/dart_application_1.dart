
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'users.dart';


List<User> filterByUsernameLength(List<User> users) {
  return users.where((user) => user.username.length > 6).toList();
}

int countUsersWithBizDomain(List<User> users) {
  return users.where((user) => user.email.endsWith('.biz')).length;
}

void main() async {

  final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
  final response = await http.get(url);

  if (response.statusCode == 200) {

    List<dynamic> jsonData = json.decode(response.body);


    List<User> users = jsonData.map((json) => User.fromJson(json)).toList();

    users.forEach((user) {
      print('User ID: ${user.id}');
      print('Nombre: ${user.name}');
      print('Username: ${user.username}');
      print('E-mail: ${user.email}');
      print('---');
    });

    print('Usuarios con username mayor a 6 caracteres:');
    List<User> filteredUsers = filterByUsernameLength(users);
    filteredUsers.forEach((user) {
      print('${user.username} (${user.name})');
    });

    int bizDomainCount = countUsersWithBizDomain(users);
    print('Cantidad de usuarios con email en dominio ".biz": $bizDomainCount');

  } else {
    // Manejo de errores
    print('Error al obtener los datos: ${response.statusCode}');
  }
}

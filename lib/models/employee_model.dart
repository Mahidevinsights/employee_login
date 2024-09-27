class Employee {
  int? id;
  String username;
  String password;
  String mobile;
  String email;
  String employeeId;
  String designation;

  Employee({
    this.id,
    required this.username,
    required this.password,
    required this.mobile,
    required this.email,
    required this.employeeId,
    required this.designation,
  });

  // Convert an Employee object to a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'mobile': mobile,
      'email': email,
      'employeeId': employeeId,
      'designation': designation,
    };
  }

  // Convert a Map object to an Employee object
  static Employee fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      mobile: map['mobile'],
      email: map['email'],
      employeeId: map['employeeId'],
      designation: map['designation'],
    );
  }
}

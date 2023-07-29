class EmpResponse{
  String? status;
  List<Employee>? data;
  String? message;

  EmpResponse({this.status, this.data, this.message});

  factory EmpResponse.fromJson(Map<dynamic, dynamic> json) => EmpResponse(
    status: json["status"],
    data: List<Employee>.from(json["data"].map((x) => Employee.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };

}

class Employee{
  int? id;
  String? employeeName;
  int? employeeSalary;
  int? employeeAge;
  String? profileImage;

  Employee({this.id, this.employeeName, this.employeeSalary, this.employeeAge, this.profileImage});

  factory Employee.fromJson(Map<dynamic, dynamic> json) => Employee(
    id: json["id"],
    employeeName: json["employee_name"],
    employeeSalary: json["employee_salary"],
    employeeAge: json["employee_age"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "employee_name" : employeeName,
    "employee_salary" : employeeSalary,
    "employee_age" : employeeAge,
    "profile_image" : profileImage,
  };
}
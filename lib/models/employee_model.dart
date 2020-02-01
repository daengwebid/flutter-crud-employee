class EmployeeModel {
  String id;
  String employeeName;
  String employeeSalary;
  String employeeAge;
  String profileImage;

  EmployeeModel({
    this.id,
    this.employeeName,
    this.employeeSalary,
    this.employeeAge,
    this.profileImage
  });

  //FORMAT TO JSON
  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    id: json['id'],
    employeeName: json['employee_name'],
    employeeSalary: json['employee_salary'],
    employeeAge: json['employee_age'],
    profileImage: json['profile_image']
  );
  
  //PARSE JSON
}

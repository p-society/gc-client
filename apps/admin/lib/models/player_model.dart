class Player {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String role;
  final String sport;
  final String branch;
  final int year;
  final String contactNo;
  final List<Map<String, String>> socials;

  Player(
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.role,
    this.sport,
    this.branch,
    this.year,
    this.contactNo,
    this.socials,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'role': role,
      'sport': sport,
      'branch': branch,
      'year': year,
      'contactNo': contactNo,
      'socials': socials,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      map['email'] as String,
      map['firstName'] as String,
      map['lastName'] as String,
      map['password'] as String,
      map['role'] as String,
      map['sport'] as String,
      map['branch'] as String,
      map['year'] as int,
      map['contactNo'] as String,
      List<Map<String, String>>.from(
        (map['socials'] as List<Map<String, String>>).map<Map<String, String>>(
          (x) => x,
        ),
      ),
    );
  }
}

class User {
  final String uid;
  final String name;
  final String email;
  final String mobileNo;
  final int age; // Make sure this is an int
  final String gender;
  final String diabetesType; // New field
  final String duration; // New field

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.age,
    required this.gender,
    required this.diabetesType, // New field
    required this.duration, // New field
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'mobileNo': mobileNo,
      'age': age,
      'gender': gender,
      'diabetesType': diabetesType, // New field
      'duration': duration, // New field
    };
  }

// Add fromJson method if you need it
}

class Doctor {
  final String uid;
  final String name;
  final String email;
  final String mobileNo;

  Doctor({
    required this.uid,
    required this.name,
    required this.email,
    required this.mobileNo,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'mobileNo': mobileNo,
    };
  }

// Add fromJson method if you need it
}

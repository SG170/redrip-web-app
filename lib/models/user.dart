class User {
  String id;
  String name;
  String email;
  String phone;
  String address;
  String userType; // 'buyer' or 'seller'
  String? profileImage;
  DateTime joinedDate;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.userType,
    this.profileImage,
    required this.joinedDate,
  });
}

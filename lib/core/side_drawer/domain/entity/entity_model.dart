class ProfileEntity {
  // final String userId;
  // final String uid;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String role;
  final String profilePic;
  final List<bool> status;

  const ProfileEntity({
    // required this.userId,
    // required this.uid,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.role,
    required this.status,
    required this.profilePic,
  });
}

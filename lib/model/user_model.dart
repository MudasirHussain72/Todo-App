class UserModel {
  String? uid;
  String? onlineStatus;
  String? profileImage;
  String? name;
  String? email;
  String? deviceToken;
  bool? isNotificationsEnabled;

  UserModel({
    this.uid,
    this.onlineStatus,
    this.name,
    this.email,
    this.isNotificationsEnabled,
    this.profileImage,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] ?? '';
    onlineStatus = json['onlineStatus'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    isNotificationsEnabled = json['isNotificationsEnabled'] ?? '';
    profileImage = json['profileImage'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['onlineStatus'] = onlineStatus;
    data['name'] = name;
    data['email'] = email;
    data['isNotificationsEnabled'] = isNotificationsEnabled;
    data['profileImage'] = profileImage;
    return data;
  }
}

class LoginRequest {
  final String username;
  final String password;

  LoginRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

class LoginResponse {
  final String accessToken;
  final String? refreshToken;
  final String id;
  final String employeeId;
  final String username;
  final String email;
  final List<String> roles;
  final bool isAdmin;

  LoginResponse({
    required this.accessToken,
    this.refreshToken,
    required this.id,
    required this.employeeId,
    required this.username,
    required this.email,
    required this.roles,
    required this.isAdmin,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'] ?? json['token'] ?? '',
      refreshToken: json['refreshToken'],
      id: json['id'] ?? '',
      employeeId: json['employeeId'] ?? json['employee_id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      roles: List<String>.from(json['roles'] ?? []),
      isAdmin: json['isAdmin'] ?? false,
    );
  }
}

class ChangePasswordRequest {
  final String oldPassword;
  final String newPassword;

  ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }
}

class ForgotPasswordRequest {
  final String email;

  ForgotPasswordRequest({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}

class ForgotPasswordResponse {
  final String message;
  final bool success;

  ForgotPasswordResponse({
    required this.message,
    required this.success,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      message: json['message'] ?? 'Request sent successfully',
      success: json['success'] ?? true,
    );
  }
}

class UserProfile {
  final String userId;
  final String username;
  final String email;
  final String name;
  final bool isAdmin;
  final bool isGoogle;
  final UserEmployeeProfile? employee;
  final Map<String, List<String>> permissions;

  UserProfile({
    required this.userId,
    required this.username,
    required this.email,
    required this.name,
    required this.isAdmin,
    required this.isGoogle,
    this.employee,
    required this.permissions,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final rawPermissions = json['permissions'];
    final parsedPermissions = <String, List<String>>{};

    if (rawPermissions is Map) {
      rawPermissions.forEach((key, value) {
        final permissionKey = key.toString();
        if (value is List) {
          parsedPermissions[permissionKey] =
              value.map((item) => item.toString()).toList();
        } else {
          parsedPermissions[permissionKey] = [];
        }
      });
    }

    return UserProfile(
      userId: (json['userId'] ?? json['id'] ?? '').toString(),
      username: (json['username'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      name: (json['name'] ?? json['fullName'] ?? '').toString(),
      isAdmin: json['isAdmin'] == true,
      isGoogle: json['isGoogle'] == true,
      employee: json['employee'] is Map<String, dynamic>
          ? UserEmployeeProfile.fromJson(json['employee'] as Map<String, dynamic>)
          : null,
      permissions: parsedPermissions,
    );
  }

  String get displayName {
    final employeeName = employee?.fullName.trim() ?? '';
    if (employeeName.isNotEmpty) {
      return employeeName;
    }
    final topLevelName = name.trim();
    if (topLevelName.isNotEmpty) {
      return topLevelName;
    }
    return username;
  }

  String get displayEmail {
    final employeeEmail = employee?.email.trim() ?? '';
    if (employeeEmail.isNotEmpty) {
      return employeeEmail;
    }
    return email;
  }

  String? get displayPhone {
    final phone = employee?.phone?.trim();
    if (phone == null || phone.isEmpty) {
      return null;
    }
    return phone;
  }

  String? get displayAddress {
    final address = employee?.address?.trim();
    if (address == null || address.isEmpty) {
      return null;
    }
    return address;
  }

  Map<String, dynamic> toStorageJson() {
    return {
      'id': userId,
      'username': username,
      'email': email,
      'name': name,
      'isAdmin': isAdmin,
      'employee': employee?.toJson(),
      'permissions': permissions,
    };
  }
}

class UserEmployeeProfile {
  final String id;
  final String employeeCode;
  final String fullName;
  final String email;
  final String? phone;
  final String? address;
  final String? status;

  UserEmployeeProfile({
    required this.id,
    required this.employeeCode,
    required this.fullName,
    required this.email,
    this.phone,
    this.address,
    this.status,
  });

  factory UserEmployeeProfile.fromJson(Map<String, dynamic> json) {
    return UserEmployeeProfile(
      id: (json['id'] ?? '').toString(),
      employeeCode: (json['employeeCode'] ?? '').toString(),
      fullName: (json['fullName'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phone: json['phone']?.toString(),
      address: json['address']?.toString(),
      status: json['status']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeCode': employeeCode,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'address': address,
      'status': status,
    };
  }
}

class UpdateMyProfileRequest {
  final String? username;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? address;

  UpdateMyProfileRequest({
    this.username,
    this.fullName,
    this.email,
    this.phone,
    this.address,
  });

  Map<String, dynamic> toJson() {
    final payload = <String, dynamic>{};

    if (username != null) {
      payload['username'] = username;
    }
    if (fullName != null) {
      payload['fullName'] = fullName;
    }
    if (email != null) {
      payload['email'] = email;
    }
    if (phone != null) {
      payload['phone'] = phone;
    }
    if (address != null) {
      payload['address'] = address;
    }

    return payload;
  }
}

class AppConstants {
  // Attendance
  static const String attendanceStatusPresent = 'present';
  static const String attendanceStatusLate = 'late';
  static const String attendanceStatusAbsent = 'absent';
  static const String attendanceStatusHalfDay = 'half_day';

  // Payroll Status
  static const String payrollStatusDraft = 'draft';
  static const String payrollStatusPendingApproval = 'pending_approval';
  static const String payrollStatusApproved = 'approved';
  static const String payrollStatusPaid = 'paid';

  // Contract Type
  static const String contractTypeProbation = 'probation';
  static const String contractTypeFixedTerm = 'fixed_term';
  static const String contractTypeIndefinite = 'indefinite';

  // Employee Status
  static const String employeeStatusActive = 'active';
  static const String employeeStatusInactive = 'inactive';
  static const String employeeStatusResigned = 'resigned';

  // Tax
  static const double taxFreeAmount = 11000000;
  static const double bhxhRate = 0.08;

  // Default values
  static const int defaultWorkDaysPerMonth = 22;
  static const int defaultWorkHoursPerDay = 8;

  // Pagination
  static const int defaultPageSize = 20;

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration shortDuration = Duration(milliseconds: 500);
  static const Duration mediumDuration = Duration(milliseconds: 1000);

  // Error messages
  static const String errorNetworkMessage = 'Lỗi kết nối. Vui lòng kiểm tra internet.';
  static const String errorServerMessage = 'Lỗi server. Vui lòng thử lại sau.';
  static const String errorUnknownMessage = 'Đã xảy ra lỗi không xác định.';
  static const String errorEmptyMessage = 'Dữ liệu rỗng.';
  static const String errorValidationMessage = 'Dữ liệu không hợp lệ.';

  // Success messages
  static const String successCreateMessage = 'Tạo mới thành công.';
  static const String successUpdateMessage = 'Cập nhật thành công.';
  static const String successDeleteMessage = 'Xóa thành công.';
  static const String successLoginMessage = 'Đăng nhập thành công.';
}

class AppRegex {
  static const String emailRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  
  static const String phoneRegex = r'^[0-9]{10,11}$';
  
  static const String passwordRegex =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$';

  static const String urlRegex =
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$';
}

class AppDurations {
  static const Duration splashDuration = Duration(seconds: 2);
  static const Duration snackBarDuration = Duration(seconds: 3);
  static const Duration dialogAnimationDuration = Duration(milliseconds: 300);
  static const Duration pageTransitionDuration = Duration(milliseconds: 500);
  static const Duration debounceDelay = Duration(milliseconds: 800);
  static const Duration throttleDelay = Duration(milliseconds: 500);
}

class AppStrings {
  // General
  static const String appName = 'HRM Mobile';
  static const String appVersion = '1.0.0';

  // Bottom navigation
  static const String homeTab = 'Trang chủ';
  static const String attendanceTab = 'Chấm công';
  static const String payrollTab = 'Lương';
  static const String profileTab = 'Hồ sơ';

  // Buttons
  static const String submitButton = 'Xác nhận';
  static const String cancelButton = 'Hủy';
  static const String saveButton = 'Lưu';
  static const String deleteButton = 'Xóa';
  static const String editButton = 'Chỉnh sửa';
  static const String nextButton = 'Tiếp tục';
  static const String backButton = 'Quay lại';
  static const String loginButton = 'Đăng nhập';
  static const String logoutButton = 'Đăng xuất';
  static const String registerButton = 'Đăng ký';
  static const String forgetPasswordButton = 'Quên mật khẩu?';

  // Validation
  static const String emptyFieldError = 'Vui lòng điền đầy đủ trường này';
  static const String invalidEmailError = 'Email không hợp lệ';
  static const String invalidPhoneError = 'Số điện thoại không hợp lệ';
  static const String passwordMismatchError = 'Mật khẩu không trùng khớp';
  static const String passwordTooShortError = 'Mật khẩu phải ít nhất 8 ký tự';
  static const String userNotFoundError = 'Tài khoản không tồn tại';
  static const String invalidCredentialsError = 'Email hoặc mật khẩu sai';
}

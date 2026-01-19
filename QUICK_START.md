# HRM Mobile - Hướng Dẫn Nhanh

## 🚀 Quick Start

### 1. Clone & Setup
```bash
cd d:\HOC_TAP\CHUONG_TRINH_DAI_HOC\HOCKI_4_2\DoAnChuyenNganh\hrm_mobile
flutter pub get
```

### 2. Cấu Hình Backend API & Database
1. Nếu dùng backend riêng (khuyến nghị), triển khai REST API trên Render/Vercel/Heroku và lấy `https://api.your-domain.com`.
2. Tạo hoặc dùng một PostgreSQL instance (Supabase DB có thể dùng nhưng không bắt buộc) và chạy SQL migrations (xem `SETUP_GUIDE.md`).
3. Update `lib/config/env.dart` (ví dụ dưới).
4. Test endpoints với Postman / mock server.

### 3. Run App
```bash
flutter run
```

## 📱 Features

| Tính năng | Status | Ghi chú |
|-----------|--------|---------|
| Login/Auth | ✅ Basic | Cần cấu hình Supabase Auth |
| Home Dashboard | ✅ Done | Menu chính |
| Chấm Công | ✅ UI Ready | QR Scanner cần test |
| Tính Lương | ✅ UI Ready | Logic sẵn + PDF Export |
| Hợp Đồng | ✅ UI Ready | CRUD operations |
| Hồ Sơ | ✅ UI Ready | Edit profile |
| Notifications | 📋 Partial | UI có sẵn |

## 🔧 Configuration

### Environment Variables
```dart
// lib/config/env.dart
Environment.apiBaseUrl = 'https://api.your-domain.com';
Environment.supabaseUrl = 'https://xxx.supabase.co';
Environment.supabaseAnonKey = 'xxx';
```

### Database Tables
- employees (Nhân viên)
- attendance (Chấm công)  
- payroll (Lương)
- contracts (Hợp đồng)
- salary_structure (Cấu trúc lương)
- employee_details (Chi tiết nhân viên)

## 📊 Salary Calculation

### Vietnam Tax Brackets (2024)
- Tax-free: 11,000,000 VND
- 0-5M: 5% | 5-10M: 10% | 10-18M: 15%
- 18-32M: 20% | 32-52M: 25% | 52-80M: 30% | >80M: 35%

### Social Insurance (BHXH)
- Employee: 8% (tính từ basic salary)

## 🧪 Testing

```bash
# Unit tests
flutter test

# Build release
flutter build apk --release
flutter build ios --release
```

## 📝 Project Structure

```
lib/
├── app.dart                 # Root
├── config/                  # Env + Theme
├── core/                    # Services + Utils
├── features/
│   ├── attendance/
│   ├── payroll/
│   ├── contract/
│   ├── profile/
│   ├── auth/
│   └── notification/
└── routes/                  # Navigation
```

## ✅ Checklist Triển Khai

- [ ] Cấu hình Supabase project
- [ ] Create & test database tables
- [ ] Update Environment variables
- [ ] Test login/auth flow
- [ ] Test QR scanner (cần real device)
- [ ] Test PDF export
- [ ] Build APK/AAB cho Android
- [ ] Build untuk iOS
- [ ] Submit lên App Store/Play Store

## 🐛 Common Issues

| Vấn đề | Giải Pháp |
|--------|----------|
| Lỗi Supabase | Check URL/Key + network |
| QR Scanner không work | Cần real device + permissions |
| PDF không download | Check storage permissions |
| Lỗi database query | Check RLS policies + SQL syntax |

## 📚 Tài Liệu Tham Khảo

- Flutter Docs: https://flutter.dev/docs
- Supabase Docs: https://supabase.com/docs
- Riverpod: https://riverpod.dev
- Get: https://github.com/jonataslaw/get

## 🎯 Next Steps

1. **Test local**: Run `flutter run` trên emulator/device
2. **Connect Supabase**: Update env variables
3. **Load sample data**: Insert test employees
4. **Test features**: Attendance → Payroll → Reports
5. **Build releases**: APK/AAB cho production

---

**Mọi thắc mắc về cấu hình, vui lòng xem SETUP_GUIDE.md chi tiết.**

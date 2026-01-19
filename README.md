# HRM Mobile - Hệ Thống Quản Lý Nhân Sự Di Động

## 📱 Tổng Quan Dự Án

HRM Mobile là ứng dụng Flutter toàn diện dành cho quản lý nhân sự, hỗ trợ các tính năng:
- ✅ **Quản lý hồ sơ nhân viên** - Lưu trữ và cập nhật thông tin chi tiết
- ✅ **Chấm công tự động** - Quét QR Code/Camera với ghi nhận thời gian realtime
- ✅ **Tính lương tự động** - Tuân theo quy định Việt Nam (BHXH 8%, Thuế TNCN)
- ✅ **Quản lý hợp đồng** - Tạo, cập nhật, theo dõi hợp đồng lao động
- ✅ **Xuất phiếu lương PDF** - Tạo phiếu lương định dạng PDF
- ✅ **Thông báo** - Nhận thông báo về lương, chấm công
- ✅ **Dashboard thống kê** - Xem tóm tắt dữ liệu nhân sự

## 🏗️ Kiến Trúc Ứng Dụng

```
Clean Architecture + Feature-based structure
├── Features (Đặc tính)
│   ├── Authentication (Xác thực)
│   ├── Attendance (Chấm công)
│   ├── Payroll (Tính lương)
│   ├── Contract (Hợp đồng)
│   ├── Profile (Hồ sơ)
│   └── Notification (Thông báo)
├── Core (Lõi ứng dụng)
│   ├── Services (Supabase, QR, PDF, etc.)
│   ├── Constants
│   ├── Utils
│   └── Widgets
├── Config (Cấu hình)
│   ├── Environment
│   └── Theme
└── Routes (Điều hướng)
```

## 🛠️ Tech Stack

| Layer | Technologies |
|-------|--------------|
| **Frontend** | Flutter 3.9+ |
| **State Management** | Riverpod + Provider |
| **Database** | Supabase PostgreSQL |
| **Authentication** | Supabase Auth |
| **QR/Camera** | mobile_scanner |
| **PDF** | pdf + printing |
| **HTTP Client** | Dio + http |
| **Local Storage** | Hive + SQLite |
| **Navigation** | GetX |
| **Serialization** | json_serializable + freezed |

## 📋 Yêu Cầu Hệ Thống

- Flutter SDK: ^3.9.2
- Dart: ^3.3.0
- Android: API 21+ (Android 5.0)
- iOS: 11.0+
- Windows: 10+
- macOS: 10.11+

## 🚀 Cài Đặt & Chạy

### 1. Clone Repository
```bash
git clone <repo-url>
cd hrm_mobile
```

### 2. Cài đặt Dependencies
```bash
flutter pub get
```

### 3. Cấu hình Supabase
- Tạo project tại [supabase.com](https://supabase.com)
- Copy URL và Anon Key
- Update `lib/config/env.dart`:
```dart
static const String supabaseUrl = 'YOUR_SUPABASE_URL';
static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
```

### 4. Chạy Database Migrations
Xem hướng dẫn trong [SETUP_GUIDE.md](SETUP_GUIDE.md)

### 5. Chạy Ứng Dụng
```bash
# Development
flutter run

# Release
flutter run --release
```

## 📱 Platform Support

- ✅ **Android** - Native support
- ✅ **iOS** - Native support
- ✅ **Web** - Responsive design
- ✅ **Windows** - Desktop support
- ✅ **macOS** - Desktop support
- ✅ **Linux** - Desktop support

## 💰 Chi Phí Triển Khai

| Dịch vụ | Chi phí | Ghi chú |
|---------|--------|---------|
| Supabase | Miễn phí | 500MB DB, 2GB bandwidth/tháng |
| Render | Miễn phí | Free tier (startup ngủ 15 phút) |
| Firebase Hosting | Miễn phí | 1GB storage, 10GB bandwidth/tháng |
| **Tổng cộng** | **Miễn phí** | ✅ 100% free tier |

## 📊 Công Thức Tính Lương

### Lương Cơ Bản
```
Lương Tháng = Lương Cơ Bản + Phụ Cấp + Thưởng
```

### Các Khoản Trừ
```
BHXH = Lương Cơ Bản × 8%
Thuế TNCN = Tính theo thang lũy tiến (xem chi tiết trong SETUP_GUIDE.md)
Tổng Trừ = BHXH + Thuế + Các khoản khác
```

### Lương Thực Nhận
```
Lương Thực = Lương Tháng - Tổng Trừ
```

## 🔐 Security

- ✅ Supabase Authentication
- ✅ Row Level Security (RLS) policies
- ✅ Secure token storage (Flutter Secure Storage)
- ✅ HTTPS/TLS encryption
- ✅ Input validation & sanitization
- ✅ Error handling & logging

## 🎯 Tính Năng Chi Tiết

### Chấm Công
- Quét QR Code tại nơi làm việc
- Ghi nhận check-in/check-out tự động
- Phân loại trạng thái (đúng giờ, muộn, vắng, nửa ngày)
- Xem lịch sử chi tiết
- Báo cáo chấm công hàng tháng

### Lương
- Tạo bảng lương hàng tháng
- Tính toán BHXH và Thuế TNCN tự động
- Xuất PDF phiếu lương cá nhân
- Xuất PDF bảng lương tất cả nhân viên
- Theo dõi lịch sử lương
- Phê duyệt lương

### Hợp Đồng
- Tạo hợp đồng (thử việc, thời hạn, vô thời hạn)
- Quản lý cấu trúc lương
- Lưu tài liệu hợp đồng
- Xem lịch sử hợp đồng
- Cảnh báo hợp đồng sắp hết hạn

### Hồ Sơ
- Xem thông tin cá nhân đầy đủ
- Cập nhật thông tin liên hệ
- Quản lý thông tin bảo hiểm
- Upload/thay đổi avatar
- Quản lý tài khoản ngân hàng

## 📚 Tài Liệu

- [QUICK_START.md](QUICK_START.md) - Hướng dẫn nhanh (5 phút)
- [SETUP_GUIDE.md](SETUP_GUIDE.md) - Hướng dẫn chi tiết (30 phút)
- [API Documentation](docs/API.md) - Chi tiết các API
- [Database Schema](docs/DATABASE.md) - Sơ đồ cơ sở dữ liệu

## 🐛 Troubleshooting

### Vấn đề Phổ Biến

1. **Lỗi Supabase Connection**
   - Kiểm tra URL và Anon Key
   - Kiểm tra kết nối internet
   - Kiểm tra Supabase project có enable không

2. **QR Scanner không hoạt động**
   - Cần chạy trên thiết bị thực (không phải emulator)
   - Kiểm tra camera permissions
   - Kiểm tra lighting (cần ánh sáng tốt)

3. **PDF Export thất bại**
   - Kiểm tra storage permissions
   - Kiểm tra dung lượng trống trên thiết bị
   - Thử với file tên ngắn hơn

4. **Lỗi Build**
   ```bash
   flutter clean
   flutter pub get
   flutter pub upgrade
   ```

## 📈 Performance

- App size: ~50MB (Android APK)
- Memory usage: ~100-150MB
- Database queries: Optimized với indexes
- Image caching: Enabled
- Lazy loading: Implemented

## 🔄 Version History

### v1.0.0 (Hiện tại)
- ✅ Login/Auth
- ✅ Quản lý nhân viên
- ✅ Chấm công & lương
- ✅ Quản lý hợp đồng
- ✅ Xuất PDF

### v1.1.0 (Sắp tới)
- Push notifications
- Offline mode
- Advanced analytics
- Multi-language support

### v2.0.0 (Tương lai)
- Biometric authentication
- Mobile web version
- Integration APIs

## 🤝 Đóng Góp

Mọi đóng góp đều được hoan nghênh! Vui lòng:
1. Fork repository
2. Tạo branch feature (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📄 License

Dự án này là mã nguồn mở dành cho mục đích giáo dục và sử dụng nội bộ công ty.

## 👥 Tác Giả

- Nhóm phát triển HRM Mobile
- Trường: [Your University]
- Giai đoạn: Đồ án chuyên ngành

## 📞 Hỗ Trợ

- 📧 Email: support@hrmmobile.local
- 💬 Issues: GitHub Issues
- 📖 Wiki: GitHub Wiki
- 🎯 Roadmap: Project Board

---

**Made with ❤️ by HRM Mobile Team**

**Last Updated:** January 2026

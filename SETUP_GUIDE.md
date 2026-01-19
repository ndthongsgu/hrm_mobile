# HRM Mobile - Hệ Thống Quản Lý Nhân Sự Di Động

## Tổng Quan Dự Án

HRM Mobile là ứng dụng di động toàn diện để quản lý nhân sự, chấm công, tính lương và quản lý hợp đồng theo quy định Việt Nam.

### Tính Năng Chính

1. **Quản Lý Hồ Sơ Nhân Viên** - Lưu trữ và cập nhật thông tin chi tiết nhân viên
2. **Chấm Công Tự Động** - Quét QR Code hoặc Camera để ghi nhận thời gian chấm công
3. **Tính Lương Tự Động** - Tính toán lương theo quy định Việt Nam (BHXH 8%, Thuế TNCN)
4. **Quản Lý Hợp Đồng** - Tạo, cập nhật, xem thông tin hợp đồng lao động
5. **Xuất Phiếu Lương PDF** - Tạo phiếu lương định dạng PDF
6. **Thông Báo** - Nhận thông báo về lương, chấm công, v.v.

## Cấu Trúc Dự Án

```
lib/
├── app.dart                  # Root widget của ứng dụng
├── main.dart                 # Entry point
├── config/
│   ├── env.dart             # Cấu hình môi trường (Supabase, API)
│   └── theme.dart           # Theme và styling
├── core/
│   ├── services/
│   │   ├── supabase_service.dart    # Kết nối Supabase
│   │   ├── qr_code_service.dart     # QR Code scanning
│   │   └── pdf_service.dart         # PDF generation
│   ├── constants/            # Constants
│   ├── utils/               # Utility functions
│   └── widgets/             # Reusable widgets
├── features/
│   ├── attendance/          # Module chấm công
│   ├── payroll/             # Module tính lương
│   ├── contract/            # Module hợp đồng
│   ├── profile/             # Module hồ sơ
│   ├── auth/                # Module xác thực
│   └── notification/        # Module thông báo
└── routes/
    └── app_routes.dart      # Navigation routing
```

## Hướng Dẫn Cấu Hình

### 1. Cài Đặt Dependencies

```bash
flutter pub get
```

### 2. Cấu Hình Backend & Database

> Lưu ý: Supabase (managed Postgres) là tùy chọn. Ứng dụng hiện dùng REST API backend; backend chịu trách nhiệm kết nối và quản lý database (PostgreSQL).

#### Bước 1: Tạo hoặc chọn Database PostgreSQL
- Bạn có thể dùng any hosted Postgres (AWS RDS, Render Postgres, DigitalOcean, Supabase DB, v.v.)
- Tạo database và chạy các SQL migrations (xem phần SQL mẫu bên dưới).

#### Bước 2: Triển khai REST API
- Triển khai server (Node/Express, FastAPI, etc.) nối tới Postgres và expose các endpoint REST (mẫu có sẵn trong SETUP_GUIDE).

#### Bước 3: Cập nhật `lib/config/env.dart`

```dart
class Environment {
  static const String apiBaseUrl = 'https://api.your-domain.com';
  // ... các config khác
}
```

#### Bước 4: Chạy SQL migrations trong DB (sử dụng SQL client hoặc migration tool)

```sql
-- Table: employees (Nhân viên)
CREATE TABLE employees (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  full_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  phone_number VARCHAR(20),
  date_of_birth DATE,
  gender VARCHAR(10),
  address TEXT,
  position VARCHAR(100),
  department VARCHAR(100),
  hire_date DATE NOT NULL,
  avatar_url TEXT,
  status VARCHAR(50) DEFAULT 'active',
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Table: attendance (Chấm công)
CREATE TABLE attendance (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  employee_id UUID REFERENCES employees(id) ON DELETE CASCADE,
  check_in_time TIMESTAMP NOT NULL,
  check_out_time TIMESTAMP,
  status VARCHAR(50) DEFAULT 'present', -- 'present', 'late', 'absent', 'half_day'
  notes TEXT,
  qr_code_data TEXT,
  location TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Table: salary_structure (Cấu trúc lương)
CREATE TABLE salary_structure (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  employee_id UUID REFERENCES employees(id) ON DELETE CASCADE,
  basic_salary DECIMAL(15, 2) NOT NULL,
  allowance DECIMAL(15, 2) DEFAULT 0,
  bonus DECIMAL(15, 2) DEFAULT 0,
  deductions DECIMAL(15, 2) DEFAULT 0,
  bhxh DECIMAL(15, 2),
  tax_amount DECIMAL(15, 2),
  net_salary DECIMAL(15, 2),
  effective_date DATE,
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Table: payroll (Bảng lương)
CREATE TABLE payroll (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  employee_id UUID REFERENCES employees(id) ON DELETE CASCADE,
  employee_name VARCHAR(255) NOT NULL,
  month INTEGER NOT NULL,
  year INTEGER NOT NULL,
  basic_salary DECIMAL(15, 2) NOT NULL,
  allowance DECIMAL(15, 2) DEFAULT 0,
  bonus DECIMAL(15, 2) DEFAULT 0,
  bhxh DECIMAL(15, 2),
  personal_income_tax DECIMAL(15, 2),
  other_deductions DECIMAL(15, 2) DEFAULT 0,
  total_deductions DECIMAL(15, 2),
  net_salary DECIMAL(15, 2),
  status VARCHAR(50) DEFAULT 'draft',
  notes TEXT,
  pdf_url TEXT,
  paid_date TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(employee_id, month, year)
);

-- Table: contracts (Hợp đồng)
CREATE TABLE contracts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  employee_id UUID REFERENCES employees(id) ON DELETE CASCADE,
  contract_type VARCHAR(50), -- 'probation', 'fixed_term', 'indefinite'
  start_date DATE NOT NULL,
  end_date DATE,
  salary DECIMAL(15, 2),
  position VARCHAR(100),
  department VARCHAR(100),
  working_location VARCHAR(255),
  contract_document TEXT,
  status VARCHAR(50) DEFAULT 'draft',
  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Table: employee_details (Chi tiết nhân viên)
CREATE TABLE employee_details (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  employee_id UUID REFERENCES employees(id) ON DELETE CASCADE,
  bank_account VARCHAR(50),
  bank_name VARCHAR(100),
  tax_code VARCHAR(50),
  insurance_number VARCHAR(50),
  emergency_contact VARCHAR(255),
  emergency_phone VARCHAR(20),
  qualifications TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Tạo Index cho hiệu suất
CREATE INDEX idx_attendance_employee_id ON attendance(employee_id);
CREATE INDEX idx_attendance_created_at ON attendance(created_at);
CREATE INDEX idx_payroll_employee_id ON payroll(employee_id);
CREATE INDEX idx_payroll_month_year ON payroll(month, year);
```

#### Bước 4: Tạo RPC Functions (để có thể gọi từ app)

```sql
-- RPC: Tính tóm tắt chấm công
CREATE OR REPLACE FUNCTION get_attendance_summary(
  p_employee_id UUID,
  p_month INTEGER,
  p_year INTEGER
)
RETURNS TABLE (
  employee_id UUID,
  total_days INTEGER,
  present_days INTEGER,
  absent_days INTEGER,
  late_days INTEGER,
  half_days INTEGER,
  attendance_rate NUMERIC,
  month_year DATE
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    a.employee_id,
    COUNT(DISTINCT DATE(a.check_in_time))::INTEGER as total_days,
    COUNT(CASE WHEN a.status = 'present' THEN 1 END)::INTEGER as present_days,
    COUNT(CASE WHEN a.status = 'absent' THEN 1 END)::INTEGER as absent_days,
    COUNT(CASE WHEN a.status = 'late' THEN 1 END)::INTEGER as late_days,
    COUNT(CASE WHEN a.status = 'half_day' THEN 1 END)::INTEGER as half_days,
    ROUND(COUNT(CASE WHEN a.status = 'present' THEN 1 END)::NUMERIC / 
          NULLIF(COUNT(DISTINCT DATE(a.check_in_time))::NUMERIC, 0) * 100, 2) as attendance_rate,
    DATE(CONCAT(p_year, '-', p_month, '-01')::TEXT)::DATE as month_year
  FROM attendance a
  WHERE a.employee_id = p_employee_id
    AND EXTRACT(MONTH FROM a.check_in_time) = p_month
    AND EXTRACT(YEAR FROM a.check_in_time) = p_year
  GROUP BY a.employee_id;
END;
$$ LANGUAGE plpgsql;

-- RPC: Tạo bảng lương cho tất cả nhân viên
CREATE OR REPLACE FUNCTION generate_monthly_payroll(
  p_month INTEGER,
  p_year INTEGER
)
RETURNS TABLE (
  id UUID,
  employee_id UUID,
  employee_name VARCHAR,
  month INTEGER,
  year INTEGER,
  basic_salary DECIMAL,
  allowance DECIMAL,
  bonus DECIMAL,
  bhxh DECIMAL,
  personal_income_tax DECIMAL,
  other_deductions DECIMAL,
  total_deductions DECIMAL,
  net_salary DECIMAL,
  status VARCHAR,
  notes TEXT,
  pdf_url TEXT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
) AS $$
BEGIN
  RETURN QUERY
  INSERT INTO payroll (
    employee_id, employee_name, month, year,
    basic_salary, allowance, bonus,
    bhxh, personal_income_tax, total_deductions,
    net_salary, status, created_at, updated_at
  )
  SELECT
    e.id,
    e.full_name,
    p_month,
    p_year,
    COALESCE(ss.basic_salary, 0),
    COALESCE(ss.allowance, 0),
    COALESCE(ss.bonus, 0),
    COALESCE(ss.basic_salary, 0) * 0.08,
    0, -- Will be calculated
    0,
    0, -- Will be calculated
    'draft',
    NOW(),
    NOW()
  FROM employees e
  LEFT JOIN salary_structure ss ON e.id = ss.employee_id
  WHERE e.status = 'active'
  ON CONFLICT DO NOTHING
  RETURNING
    payroll.id,
    payroll.employee_id,
    payroll.employee_name,
    payroll.month,
    payroll.year,
    payroll.basic_salary,
    payroll.allowance,
    payroll.bonus,
    payroll.bhxh,
    payroll.personal_income_tax,
    payroll.other_deductions,
    payroll.total_deductions,
    payroll.net_salary,
    payroll.status,
    payroll.notes,
    payroll.pdf_url,
    payroll.created_at,
    payroll.updated_at;
END;
$$ LANGUAGE plpgsql;

-- RPC: Lấy tóm tắt lương
CREATE OR REPLACE FUNCTION get_payroll_summary(
  p_month INTEGER,
  p_year INTEGER
)
RETURNS TABLE (
  month INTEGER,
  year INTEGER,
  total_employees INTEGER,
  processed_payroll INTEGER,
  total_basic_salary DECIMAL,
  total_allowances DECIMAL,
  total_deductions DECIMAL,
  total_net_salary DECIMAL,
  status VARCHAR,
  created_at TIMESTAMP
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    p_month,
    p_year,
    COUNT(DISTINCT pr.employee_id)::INTEGER,
    COUNT(CASE WHEN pr.status IN ('approved', 'paid') THEN 1 END)::INTEGER,
    COALESCE(SUM(pr.basic_salary), 0),
    COALESCE(SUM(pr.allowance), 0),
    COALESCE(SUM(pr.total_deductions), 0),
    COALESCE(SUM(pr.net_salary), 0),
    CASE 
      WHEN COUNT(CASE WHEN pr.status = 'paid' THEN 1 END) = COUNT(*) THEN 'paid'
      WHEN COUNT(CASE WHEN pr.status IN ('approved', 'paid') THEN 1 END) > 0 THEN 'partial'
      ELSE 'draft'
    END,
    NOW()
  FROM payroll pr
  WHERE pr.month = p_month AND pr.year = p_year;
END;
$$ LANGUAGE plpgsql;
```

### 3. Cấu Hình Authentication

Supabase tự động cung cấp authentication. Bạn có thể dùng:
- Email/Password
- Social login (Google, GitHub, etc.)

### 4. Build & Run

```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Web
flutter run -d web

# Windows
flutter run -d windows
```

## API Endpoints

Ứng dụng giờ yêu cầu một **RESTful API backend** để thay thế việc gọi trực tiếp Supabase từ client. API này chịu trách nhiệm expose các endpoint business logic (tính lương, tổng hợp chấm công, xuất PDF links, v.v.) và gọi các RPC/database an toàn.

- **Cập nhật `lib/config/env.dart`**: đặt `Environment.apiBaseUrl = 'https://api.your-domain.com'`

- **Các endpoint mẫu (backend phải implement):**
  - Attendance
    - GET  /api/attendance?employee_id={id}&start_date={yyyy-mm-dd}&end_date={yyyy-mm-dd}
    - POST /api/attendance
    - PUT  /api/attendance/{id}
    - GET  /api/attendance/summary?employee_id={id}&month={m}&year={y}
  - Employees / Profile
    - GET  /api/employees
    - GET  /api/employees/{id}
    - GET  /api/employees/{id}/detail
    - POST /api/employees
    - PUT  /api/employees/{id}
  - Payroll
    - GET  /api/payroll?employee_id={id}&month={m}&year={y}
    - POST /api/payroll
    - PUT  /api/payroll/{id}
    - POST /api/payroll/generate  (body: { "month": m, "year": y })
    - GET  /api/payroll/summary?month={m}&year={y}
    - DELETE /api/payroll/{id}

- **Triển khai backend:** bạn có thể triển khai trên Render (miễn phí tier), Heroku, Vercel, hoặc Supabase Edge Functions. Backend nên:
  - Kết nối tới PostgreSQL (Supabase DB) và thực thi các RPC/queries an toàn
  - Implement rule-based authorization (RLS + JWT) hoặc API-level auth
  - Trả kết quả JSON theo contract ứng dụng

> Ghi chú: mã nguồn hiện tại đã chuyển repository để gọi `ApiService` (Dio). Nếu backend chưa có, bạn có thể tạm chạy mock server (JSON Server / Postman mock) để phát triển front-end trước khi deploy.

## Tính Năng Chi Tiết

### 1. Chấm Công
- Quét QR Code tại nơi làm việc
- Ghi nhận thời gian check-in/check-out
- Tự động phân loại (đúng giờ, muộn, vắng mặt, nửa ngày)
- Xem lịch sử chấm công
- Thống kê chấm công theo tháng

### 2. Tính Lương
- **Công Thức Tính Lương:**
  ```
  Lương tháng = Lương cơ bản + Phụ cấp + Thưởng
  BHXH = Lương cơ bản × 8%
  Thuế TNCN = Tính theo thang lũy tiến Việt Nam
  Lương thực nhận = Lương tháng - BHXH - Thuế - Các khoản trừ khác
  ```

- **Thang Thuế TNCN (2024):**
  ```
  Tiền miễn trừ: 11.000.000 VND
  0 - 5.000.000 VND: 5%
  5.000.001 - 10.000.000 VND: 10%
  10.000.001 - 18.000.000 VND: 15%
  18.000.001 - 32.000.000 VND: 20%
  32.000.001 - 52.000.000 VND: 25%
  52.000.001 - 80.000.000 VND: 30%
  >80.000.000 VND: 35%
  ```

- Tạo bảng lương hàng tháng
- Xuất phiếu lương PDF
- Phê duyệt và thanh toán

### 3. Quản Lý Hợp Đồng
- Tạo hợp đồng probation/fixed-term/indefinite
- Quản lý cấu trúc lương
- Lưu tài liệu hợp đồng
- Xem lịch sử hợp đồng

### 4. Quản Lý Hồ Sơ
- Xem thông tin cá nhân
- Cập nhật thông tin liên hệ
- Quản lý thông tin bảo hiểm
- Upload avatar

## Database Migrations

Khi muốn thay đổi schema, hãy:

1. Tạo backup dữ liệu
2. Chạy SQL migration trong Supabase SQL Editor
3. Cập nhật models trong code
4. Test trên staging trước khi deploy

## Deployment

### Render (Backend - opsional)
- Dùng để tạo API custom nếu cần
- Supabase đã có database + API sẵn

### Mobile App
- **Android**: Build APK/AAB rồi upload lên Play Store
- **iOS**: Build lên App Store
- **Web**: Deploy lên Firebase Hosting, Vercel, hoặc tương tự

## Troubleshooting

### Lỗi Supabase Connection
```
Kiểm tra:
- URL và Anon Key có chính xác?
- Network connection có ổn định?
- Supabase project có enable được?
```

### Lỗi Permission Denied
```
Thêm Row Level Security (RLS) policies:
- Mỗi user chỉ xem được data của mình
- Admins có quyền xem/sửa tất cả
```

### Lỗi QR Scanner
```
Kiểm tra permissions:
- Android: camera permission in AndroidManifest.xml
- iOS: camera permission in Info.plist
```

## Phát Triển Tiếp

### Phase 2 (Trong tương lai)
- [ ] Push notifications (Firebase)
- [ ] Offline mode (Hive local storage)
- [ ] Advanced analytics
- [ ] Mobile scanner improvements
- [ ] Multi-language support
- [ ] Dark mode

### Phase 3
- [ ] Biometric authentication
- [ ] Advanced reporting
- [ ] Integration với external HRIS
- [ ] Mobile web version

## License & Support

Dự án này được phát triển cho mục đích đào tạo và có thể tùy chỉnh theo nhu cầu công ty.

## Liên Hệ

Để hỏi đáp hoặc báo cáo lỗi, vui lòng liên hệ team phát triển.

---

**Happy Coding! 🚀**

# 🛵 Đơn Hàng Pro

Hệ thống quản lý đơn hàng real-time với Next.js + Supabase.

## Tính năng
- ✅ Chỉnh sửa inline trực tiếp trên bảng (click vào ô là sửa được)
- ✅ Tab/Shift+Tab để di chuyển giữa các ô
- ✅ Real-time sync — nhiều người dùng cùng lúc, thay đổi hiện ngay
- ✅ Quản lý nhiều đợt (Đợt 1–4), mỗi đợt độc lập
- ✅ Xuất Excel theo từng đợt
- ✅ Biểu đồ doanh thu + tỉ lệ trạng thái
- ✅ Thêm / xoá đơn
- ✅ Lọc theo trạng thái, tìm kiếm theo tên/SĐT/địa chỉ

---

## Cài đặt

### 1. Cài dependencies
```bash
npm install
```

### 2. Tạo Supabase project (miễn phí)
1. Vào https://supabase.com → **New Project**
2. Đặt tên project, chọn region **Southeast Asia (Singapore)**
3. Vào **SQL Editor** → **New Query** → paste nội dung file `supabase-schema.sql` → **Run**

### 3. Lấy API keys
Vào **Project Settings** → **API**:
- Copy **Project URL**
- Copy **anon public** key

### 4. Tạo file `.env.local`
```bash
cp .env.example .env.local
```
Điền vào:
```
NEXT_PUBLIC_SUPABASE_URL=https://xxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGci...
```

### 5. Chạy dev
```bash
npm run dev
```
Mở http://localhost:3000

---

## Deploy lên Vercel (miễn phí)

```bash
npm install -g vercel
vercel
```
Thêm 2 environment variables trong Vercel dashboard giống như `.env.local`.

---

## Cấu trúc project

```
src/
├── app/
│   ├── layout.tsx          # Root layout + fonts
│   ├── globals.css         # Tailwind + custom styles
│   └── dashboard/
│       └── page.tsx        # Trang chính (toàn bộ logic)
├── components/
│   ├── orders/
│   │   ├── StatsRow.tsx    # 5 thống kê đầu trang
│   │   ├── OrderTable.tsx  # Bảng đơn + inline editing
│   │   └── AddOrderModal.tsx
│   └── charts/
│       └── RevenueChart.tsx  # Bar chart + Pie chart
└── lib/
    ├── supabase.ts         # Client + queries
    ├── export.ts           # Xuất Excel
    └── utils.ts            # cn(), fmtMoney(), parseMoney()
```

---

## Thêm tính năng sau

- **Auth** (đăng nhập): thêm Supabase Auth + middleware
- **Thêm đợt mới**: insert vào bảng `batches`
- **In đơn**: `window.print()` + CSS print media query
- **Lịch sử thay đổi**: bật Supabase Audit Log hoặc thêm bảng `order_history`

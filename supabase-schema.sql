-- ============================================================
-- Chạy file này trong Supabase SQL Editor
-- Dashboard → SQL Editor → New Query → paste → Run
-- ============================================================

-- Bảng đợt (batch)
create table if not exists batches (
  id    serial primary key,
  name  text not null,          -- 'Đợt 1', 'Đợt 2' ...
  created_at timestamptz default now()
);

insert into batches (name) values ('Đợt 1'), ('Đợt 2'), ('Đợt 3'), ('Đợt 4')
on conflict do nothing;

-- Bảng đơn hàng
create table if not exists orders (
  id          uuid primary key default gen_random_uuid(),
  batch_id    int  references batches(id) on delete cascade,
  stt         int,
  name        text default '',
  phone       text default '',
  addr        text default '',
  items       text default '',
  gia_ship    numeric default 0,
  phi_ship    numeric default 0,
  total       numeric default 0,
  note        text default '',
  status      text default 'pending' check (status in ('pending','done','issue')),
  created_at  timestamptz default now(),
  updated_at  timestamptz default now()
);

-- Index tìm kiếm nhanh
create index if not exists orders_batch_idx on orders(batch_id);
create index if not exists orders_status_idx on orders(status);

-- Tự cập nhật updated_at
create or replace function set_updated_at()
returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end; $$;

drop trigger if exists orders_updated_at on orders;
create trigger orders_updated_at
  before update on orders
  for each row execute function set_updated_at();

-- Real-time: bật replication cho bảng orders
alter publication supabase_realtime add table orders;

-- Row Level Security (cho phép tất cả đọc/ghi – có thể thêm auth sau)
alter table orders  enable row level security;
alter table batches enable row level security;

create policy "allow_all_orders"  on orders  for all using (true) with check (true);
create policy "allow_all_batches" on batches for all using (true) with check (true);

-- Seed dữ liệu mẫu Đợt 4
insert into orders (batch_id, stt, name, phone, addr, items, gia_ship, phi_ship, total, note, status) values
(4,1,'Thanh Trúc','0932600359','119/1/2A Đỗ Tần Phong, tấn đồng hiệp dĩ an','Cơm 15,6',0,0,702000,'','done'),
(4,2,'Hương','0903820741','324 Đô Pháp Thuận PÁn Phú Q2','Quả 2q 5-6kg',0,0,45000,'','pending'),
(4,3,'Mia','0867781901','231/44B Đường Đình Hội, Tăng Nhơn Phú','Quả 1q 3kg',0,0,45000,'tối mai','pending'),
(4,4,'Phương Trúc','0329471735','chung cư bình làm','Cơm 1 / Măng cụt 1',155000,60000,215000,'','pending'),
(4,5,'Như Quỳnh','0383530969','28/20/4 đường 16, lĩnh chiêu','Quả 1q 3kg',0,0,45000,'','pending'),
(4,6,'Dũng','0938944082','10 Đặng Minh Khiêm','Cơm 1',170000,0,170000,'','pending'),
(4,7,'Thảo Vy','0968233716','59/2 đường số 5, lĩnh chiêu','Quả 1q 2kg',0,0,45000,'','pending'),
(4,8,'imeirok','0369246492','18H, tăng nhơn phú, phước long B','Cơm 1 / Măng cụt 1 / Quả 1q 2kg',45000,60000,105000,'','pending'),
(4,9,'','','631/6 lê đức thọ','Cơm 1 / Quả 1q 2kg',0,15000,15000,'','pending'),
(4,10,'','','','Cơm 3 / 7q sống',0,0,0,'','pending'),
(4,11,'Hiền','','TH3 group','Cơm 5q',45000,0,45000,'','pending'),
(4,12,'Thanh Phong','','529 kha vạn cân, kp8, hiệp bình chánh','Cơm 1',155000,0,146000,'','done'),
(4,13,'An','0938042790','787 lũy bán bích, phú thọ hoà tân phú','Cơm 5,2',45000,20000,254000,'','issue'),
(4,14,'Quỳnh','0383745603','208 Nguyễn Gia Trí, Bình Thạnh','Cơm 2,7 / Măng cụt 2',45000,15000,241500,'','pending'),
(4,15,'Ngọc Mai','0947066175','70 đường bạch đằng, p2, tân bình','Cơm 2q',45000,0,45000,'','pending'),
(4,16,'thị','0935357109','80/38 đường số 3 phường 9 gò vấp','Cơm 1',155000,15000,170000,'','pending'),
(4,17,'mai lĩnh','0376599474','20/9 đường 25, phường Hiệp Bình Chánh, HCM','Cơm 9,5',45000,0,427500,'','pending'),
(4,18,'Bảo Hà','0777631102','440/75 Thống Nhất F16 Gò Vấp','Cơm 3',155000,0,465000,'','pending');

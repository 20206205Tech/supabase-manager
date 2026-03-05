-- 1. Tạo bucket (nếu chưa dùng code Python ở trên)
insert into storage.buckets (id, name, public)
values ('persona_avatars', 'persona_avatars', true)
on conflict (id) do nothing;

-- 2. Công khai: Ai cũng có thể xem ảnh nhân vật
create policy "Persona avatars are public"
  on storage.objects for select
  using ( bucket_id = 'persona_avatars' );

-- 3. Chỉ ADMIN mới được thêm/sửa/xóa ảnh nhân vật
-- Lưu ý: Nếu bạn dùng Service Role Key trong Backend thì không cần policy này, 
-- nhưng thêm vào cho an toàn nếu bạn dùng Client SDK ở nơi khác.
create policy "Admins can manage persona avatars"
  on storage.objects for all
  to authenticated
  using ( bucket_id = 'persona_avatars' );
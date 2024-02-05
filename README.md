# tlutopia 🔖💌
[5/2/24] 🏫 Unreleased Version 0.5:
- Cách để chạy: Bắt buộc phải gõ "flutter pub get" ở terminal để khởi tạo
- Trong code có 1 tài khoản toàn quyền tên admin, pass: admin, mọi người có thể dùng nó để đăng nhập

🆕 Bản 0.5 có gì?:
- Code server ở branch riêng server-thanh
- Code client ở master, bao gồm các tính năng sau:
  + Đặt lịch hẹn mượn sách, thay đổi tài khoản, xem lại các lịch hẹn
  + Trong tương lai có gì: hiển thị thông báo, đổi mật khẩu, chế độ DarkMode và hơn thế nữa, đặt lịch hẹn với khoảng cách xa hơn
  + Sử dụng api http://tlu-booklending.mooo(.)com/api/ để chạy các hoạt động của app
- Client đã được tạo ra theo luồng sau:
  + Everything is Object!: các đối tượng User, Book, Schedule, Cart, BookingCalendar, Picker
  + Các đối tượng chính như User và BookingCalendar kế thừa InheritedWidget để đồng bộ thông tin ở mọi màn hình
  + Tách các màn hình vào từng folder nhỏ lẻ, dễ chỉnh sửa và bảo trì sau này.
- Nhờ sự trơn tru trong làm việc, API đã được thành viên Thành xử lí rất tốt để dễ sử dụng hơn.

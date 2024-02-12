# tlutopia 🎏🪅
[12/2/24]📱Unreleased Version 0.6 / Local:
- Cách để chạy: Bắt buộc phải gõ "flutter pub get" ở terminal để khởi tạo
- Trong code có 1 tài khoản toàn quyền tên admin, pass: admin, mọi người có thể dùng nó để đăng nhập
- Hiện tại chúng tôi chưa tìm được host API, nên ứng dụng sẽ chưa thể sử dụng online.

🆕🎏 Bản 0.6 có gì?:
- 😓 Lưu ý, phiên bản này chưa thể chạy API online mà chỉ có thể sử dụng với server localhost.
- 🥳 Thông tin về phiên bản 0.6:
  + Tinh chỉnh toàn diện và tối ưu giao diện ứng dụng.
  + Chuẩn hóa luồng màn hình (Stack) và toàn bộ đối tượng (Model).
  + Cập nhật thêm tính năng tìm kiếm sách, có thể lọc kết quả tìm kiếm theo ngành.
  + Sửa một số lỗi hiển thị và overflow, tối ưu hóa trải nghiệm người dùng.
  + Cập nhật tính năng xem thông tin cá nhân ở màn hình, xem các câu hỏi thường gặp và nút đăng xuất.
  + Tối ưu thêm vấn đề hiển thị chậm khi cập nhật lịch hẹn mượn sách.
- 🤔 Cách để chạy localhost:
  + Tải toàn bộ tài nguyên tại đây: https://drive.google.com/file/d/1SH5PucMkMu5EtQy3f8GLa4987sYa82Fw/view?usp=sharing
  + Tải về XXAMP để chạy server và database trên localhost
  + Sau đó, bật Apache và MySQL của XXAMP lên, giải nén thư viện aserver và di chuyển thư mục vào đường dẫn C:\xampp\htdocs
  + Mở trên trình duyệt localhost/phpmyadmin, tìm đến "Mới -> SQL", copy toàn bộ lệnh ở sample.sql (có trong thư mục aserver) vào đó rồi ấn "Thực hiện"
  + Tìm đến toàn bộ lệnh gọi API trong thân ứng dụng, đổi địa chỉ "192.168.1.8" thành địa chỉ IPv4 máy tính của máy bạn
  + Sử dụng máy ảo Android để chạy ứng dụng (do chế độ bảo vệ, máy ảo Chrome sẽ tự động cấm mọi phương thức liên lạc không hợp lệ tới API)
- 🤓 Nếu vẫn muốn sử dụng máy ảo Chrome, làm theo các bước sau:
  + Mở Terminal/Command Prompt của máy tính lên
  + Enter lệnh: cd C:\Program Files\Google\Chrome\Application
  + Enter tiếp: chrome. exe -- user-data-dir="C: //Chrome dev session" -- disable-web-security
  + Việc này sẽ mở một cửa sổ Chrome (không có chế độ bảo vệ)
  + Ấn Start Debugging ở VSCode bằng máy ảo Chrome, sau đó một cửa sổ Chrome có 1 địa chỉ localhost://port sẽ hiện lên
  + Copy địa chỉ đó vào cửa sổ Chrome (không có chế độ bảo vệ) -> Thành công

# tlutopia

A new Flutter project.

Demo cho FrontEnd: 4/2/2024
- Để demo được tính năng đăng nhập, đầu tiên hãy mở XXAMP lên, tạo một folder tên aserver ở htdocs trong folder của XXAMP
- Tải các lệnh api từ đây: https://drive.google.com/file/d/1CFpXuh6j6byJKYqjr28rpZgWpf6jzW9m/view?usp=sharing
- Thay đổi toàn bộ địa chỉ gọi api ở các file trong lib, ví dụ như RegisterScreen, LoginScreen,.. (vì localhost ở máy mình là 192.168.1.10, nhưng máy các bạn sẽ có địa chỉ khác)
- Tạo một database trên phpmyadmin tên thuvien, tạo bảng student có các cột (studentName, studentCode, studentPass, studentPhoneNum, studentEmail), tạo bảng notify có các cột (title, source, description)
- Bắt buộc phải gõ flutter pub get trên terminal trước khi chạy
- Sau đó, trong file main.dart, đổi thành LoginScreen() để bắt đầu chạy

- Trong code có 1 tài khoản toàn quyền tên admin, pass: admin, mọi người có thể dùng nó để đăng nhập 

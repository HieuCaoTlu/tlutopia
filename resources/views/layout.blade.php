<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Admin</title>
    @vite('resources/css/app.css')
</head>
<body>
    <nav class="border-b-gray-50 border-b">
        <ul class="flex items-center justify-center  border-b border-b-gray-500 h-16 bg-slate-200 font-semibold">
            <li class="h-full"><a href="/" class="block h-full flex items-center hover:text-white hover:bg-slate-500 px-3">Books</a></li>
            <li class="h-full"><a href="" class="block h-full flex items-center hover:text-white hover:bg-slate-500 px-3">Majors</a></li>
            <li class="h-full"><a href="" class="block h-full flex items-center hover:text-white hover:bg-slate-500 px-3">Courses</a></li>
            <li class="h-full"><a href="" class="block h-full flex items-center hover:text-white hover:bg-slate-500 px-3">Loans</a></li>
            <li class="h-full"><a href="" class="block h-full flex items-center hover:text-white hover:bg-slate-500 px-3">Accounts</a></li>
        </ul>
    </nav>
    <div>
        @yield('content')
    </div>
</body>
</html>
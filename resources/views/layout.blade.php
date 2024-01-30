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
    <nav class="flex justify-between items-center border-b border-b-gray-500 bg-slate-200 px-4">
        <ul class="flex items-center justify-center font-semibold h-16">
            <li class="h-full"><a href="/book/list" class="block h-full flex items-center hover:text-white hover:bg-slate-500 px-3">Books</a></li>
            <li class="h-full"><a href="" class="block h-full flex items-center hover:text-white hover:bg-slate-500 px-3">Loans</a></li>
            <li class="h-full"><a href="" class="block h-full flex items-center hover:text-white hover:bg-slate-500 px-3">Accounts</a></li>
        </ul>
        <div><a href="/admin/logout" class="hover:underline">Log out</a></div>
    </nav>
    <div>
        @yield('content')
    </div>
</body>
</html>
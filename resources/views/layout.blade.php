<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Admin</title>
    <link rel="icon" href="logo.png"/>
    @vite('resources/css/app.css')
</head>
<body class="relative">
    <nav class="flex justify-between items-center border-b border-b-gray-500 bg-slate-200 px-4">
        <img src="/logo.png" alt="" class="h-14 mt-3">
        <ul class="flex items-center justify-center font-semibold h-16">
            <li class="h-full"><a href="/book/list" class="h-full flex items-center hover:text-white hover:bg-slate-500 px-3">Books</a></li>
            <li class="h-full"><a href="/loan/list" class="h-full flex items-center hover:text-white hover:bg-slate-500 px-3">Loans</a></li>
            <li class="h-full"><a href="/user/list" class="h-full flex items-center hover:text-white hover:bg-slate-500 px-3">Users</a></li>
            <li class="h-full"><a href="/admin/list" class="h-full flex items-center hover:text-white hover:bg-slate-500 px-3">Admins</a></li>
        </ul>
        <form action="/admin/logout" method="POST">@csrf<button  class="hover:underline">Log out</button></form>
    </nav>
    @if (session()->has('message'))
        <div id="alert" class="absolute bottom-1 right-1 px-8 py-3 bg-slate-400 text-black">
            {{session()->get('message')}}
        </div>
        <script>
            setTimeout(function() {
                document.getElementById("alert").style.display = "none";
            }, 3000);
        </script>
    @endif
    <div class="">
        @yield('content')
    </div>
</body>
</html>
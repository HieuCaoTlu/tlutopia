<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Log in</title>
    @vite('resources/css/app.css')
</head>
<body>
    <div class="h-full w-full flex items-center justify-center">
        <form action="/admin/authenticate" method="POST" class="w-full h-full sm:w-[60%] sm:h-[80%] sm:border sm:border-gray-600 sm:rounded-lg flex flex-col items-center p-6">
            @csrf
            <div class="font-serif text-3xl font-bold">LOG IN</div>
            <div class="my-6 w-[200px]">
                <label for="username">Username</label>
                <input type="text" placeholder="Username" name="username" id="username" class="border border-black rounded-md p-2">
            </div>
            <div class="w-[200px]">
                <label for="password">Password</label>
                <input type="password" placeholder="Password" name="password" id="password" class="border border-black rounded-md p-2">
            </div>
            <div class="mb-4 w-[200px] flex">
                <input type="checkbox" name="remember" id="remember">
                <label class="ml-1" for="remember">Stay logged in?</label>
            </div>
            @error('username')
                <div class="text-red-500 text-sm mt-1">{{$message}}</div>
            @enderror
            @error('password')
                <div class="text-red-500 text-sm mt-1">{{$message}}</div>
            @enderror
            <button type="submit" class="border border-black rounded-lg px-6 py-2">Log in</button>
        </form>
    </div>
</body>
</html>
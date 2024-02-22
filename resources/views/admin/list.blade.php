@extends('layout')

@section('content')
@php
    $admin = auth()->guard('admin')->user();
@endphp
<div class="p-2 sm:p-4 w-full">
    <div class="w-full">
        <div class="mb-4 flex justify-between">
            <div class="font-semibold text-xl ">All admins</div>
            <button class="rounded-md bg-slate-200 hover:opacity-70 px-4 py-2" onclick="openAddAdmin({{$admin->create_admin}})">Create admin</button>
        </div>
        
        <div class="w-full">
            <table class="w-full border-collapse text-center border border-gray-500">
                <thead>
                    <tr>
                        <td class="border border-gray-500 sm:w-[80px] font-semibold">ID</td>
                        <td class="border border-gray-500 sm:w-[500px] overflow-hidden font-semibold">Username</td>
                        <td class="border border-gray-500 sm:w-[250px] overflow-hidden font-semibold">Title</td>
                        <td class="border border-gray-500">Admin privileges</td>
                        <td class="border border-gray-500 sm:w-[250px] font-semibold">Date created</td>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($adminList as $account)
                        <tr class="border border-gray-300">
                            <td>{{$account->id}}</td>
                            <td>{{$account->username}}</td>
                            <td>{{$account->title}}</td>
                            <td>
                                <form action="/admin/update" method="POST">
                                    @csrf
                                    <input type="hidden" name="id" type="id" value="{{$account->id}}">
                                    <input type="checkbox" name="privileges" id="privileges" 
                                        @disabled(!$admin->create_admin || $admin->id == $account->id) 
                                        @checked($account->create_admin)
                                        onchange="this.form.submit()"
                                    >
                                </form>
                            </td>
                            <td>{{$account->created_at}}</td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
            <div class="mt-3">{{$adminList->links()}}</div>
        </div>
    </div>
</div>

<div id="add-admin-overlay" class="hidden fixed top-0 left-0 bg-black bg-opacity-70 h-full w-full items-center justify-center">
    <div id="add-admin-modal" class="h-full w-full sm:h-[80%] sm:w-[80%] bg-white rounded-md relative p-5">
        <button class="absolute top-3 right-4" onclick="closeAddAdmin()">&#x2715;</button>
        <div class="text-xl font-semibold border-b border-b-gray-400 h-10">Create new admin</div>
        <form action="/admin/store" method="post" class="mt-5 w-full h-[calc(100%-40px)] overflow-y-auto ">
            @csrf
            <div class="w-full lg:flex lg:justify-center lg:gap-10 lg:mt-10">
                <div>
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="username" class="inline-block w-[100px]">Username</label>
                        <input type="text" id="username" name="username" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full">
                        @error('username')
                            <div class="text-red-500 text-sm">{{$message}}</div>
                        @enderror
                    </div>
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="title" class="inline-block w-[100px]">Title</label>
                        <input type="text" id="title" name="title" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full">
                        @error('title')
                            <div class="text-red-500 text-sm">{{$message}}</div>
                        @enderror
                    </div>
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="password" class="inline-block w-[100px]">Password</label>
                        <input type="password" id="password" name="password" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full">
                        @error('password')
                            <div class="text-red-500 text-sm">{{$message}}</div>
                        @enderror
                    </div>
                    <div class=" flex items-center mb-4">
                        <label for="create_admin" class="inline-block">Create admin and post notification privilege</label>
                        <input type="checkbox" id="create_admin" name="create_admin" class="ml-2">
                    </div>
                </div>
            </div>
            <div class="w-full flex justify-center mt-5">
                <button type="submit" class="border border-black rounded-full w-24 h-12 mb-3">Save</button>
            </div>
        </form>
    </div>
</div>
<script>
    const addOverlay = document.getElementById("add-admin-overlay");
    addOverlay.addEventListener('click', function(event) {
        const targetElement = event.target;
        
        const modal = document.getElementById("add-admin-modal");
        if (!modal.contains(targetElement) && addOverlay.style.display !== "none") {
            addOverlay.style.display = "none";
        }
    });

    function openAddAdmin(create_admin) {
        if (create_admin)
            addOverlay.style.display = "flex";
        else 
            alert('This account can\'t create admins');
    }

    function closeAddAdmin() {
        addOverlay.style.display = "none";
    }
</script>
@endsection
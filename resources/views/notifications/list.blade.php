@extends('layout')

@section('content')
<div class="p-2 sm:p-4 w-full">
    <div class="w-full mb-6">
        <form action="/notification/store" method="POST" class="@php
            echo (auth()->guard('admin')->user()->create_admin) ? "" : "hidden"
        @endphp">
            @csrf
            <div class="font-semibold text-xl ">Post new notification</div>
            <textarea name="content" id="content" class="w-full border border-black rounded p-1" rows="6"></textarea>
            <div class="flex justify-end">
                <button class="rounded-md bg-slate-200 hover:opacity-70 px-4 py-2">Post</button>
            </div>
        </form>
    </div>
    <div class="w-full">
        <div class="mb-4 flex justify-between">
            <div class="font-semibold text-xl ">All notifications</div>
            
        </div>
        
        <div class="w-full">
            <table class="w-full border-collapse text-center border border-gray-500">
                <thead>
                    <tr>
                        <td class="border border-gray-500 sm:w-[80px] overflow-hidden font-semibold">ID</td>
                        <td class="border border-gray-500 overflow-hidden font-semibold">Admin posted</td>
                        <td class="border border-gray-500 sm:w-[600px] overflow-hidden font-semibold">Content</td>
                        <td class="border border-gray-500 overflow-hidden font-semibold">Date posted</td>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($notificationList as $notification)
                        <tr class="border border-gray-300">
                            <td>{{$notification->id}}</td>
                            <td>{{$notification->user_id}}</td>
                            <td>{{$notification->content}}</td>
                            <td>{{$notification->date_created}}</td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
            <div class="mt-3">{{$notificationList->links()}}</div>
        </div>
    </div>
</div>

<script>
   
</script>
@endsection
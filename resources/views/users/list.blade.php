@extends('layout')

@section('content')

<div class="p-2 sm:p-4 w-full">
    <div class="w-full">
        <div class="mb-4 flex justify-between">
            <div class="font-semibold text-xl ">All users</div>
        </div>
        
        <div class="w-full">
            <table class="w-full border-collapse text-center border border-gray-500">
                <thead>
                    <tr>
                        <td class="border border-gray-500 overflow-hidden font-semibold">ID</td>
                        <td class="border border-gray-500 overflow-hidden font-semibold">Student code</td>
                        <td class="border border-gray-500 overflow-hidden font-semibold">Student name</td>
                        <td class="border border-gray-500 overflow-hidden font-semibold">Email</td>
                        <td class="border border-gray-500 overflow-hidden font-semibold">Phone number</td>
                        <td class="border border-gray-500 overflow-hidden font-semibold">Status</td>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($userList as $user)
                        <tr>
                            <td>{{$user->id}}</td>
                            <td>{{$user->student_code}}</td>
                            <td>{{$user->student_name}}</td>
                            <td>{{$user->email}}</td>
                            <td>{{$user->phone}}</td>
                            <td>{{$user->status}}</td>
                            
                        </tr>
                    @endforeach
                </tbody>
            </table>
            <div class="mt-3">{{$userList->links()}}</div>
        </div>
    </div>
</div>

@endsection
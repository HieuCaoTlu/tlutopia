@extends('layout')

@section('content')
@php
    $user = $loan->user;
@endphp
<div class="h-full w-full flex justify-center">
    <div class="h-full w-full sm:h-[80%] sm:w-[80%] mt-4 border border-black bg-white rounded-md relative p-5">
        <div class="text-xl font-semibold border-b border-b-gray-400 h-10">Loan details</div>
        <form action="/loan/update" method="post" class="mt-5 w-full overflow-y-auto">
            @csrf
            <input type="hidden" value="{{$loan->id}}" id="id" name="id">
            <div class="w-4/5 mx-auto lg:flex lg:justify-center lg:gap-10 lg:mt-5">
                <div class="w-full md:w-1/2 flex flex-col gap-2">
                    <div class="flex w-full">
                        <div class="w-1/2 font-medium">Loan ID</div>
                        <div class="w-1/2">{{$loan->id}}</div>
                    </div>
                    <div class="flex w-full">
                        <div class="w-1/2 font-medium">Book title</div>
                        <div class="w-1/2">{{$loan->book_title}}</div>
                    </div>
                    <div class="flex w-full items-center justify-center mt-4">
                        <img src="{{$loan->book_cover}}" alt="" class="w-[150px] shadow-black shadow-lg mb-5">
                    </div>
                </div>
                <div class="w-full md:w-1/2 flex flex-col gap-2">
                    <div class="flex w-full">
                        <div class="w-1/2 font-medium">Student code</div>
                        <div class="w-1/2 ">{{$user->student_code}}</div>
                    </div>
                    <div class="flex w-full">
                        <div class="w-1/2 font-medium">Student name</div>
                        <div class="w-1/2">{{$user->student_name}}</div>
                    </div>
                    <div class="flex w-full">
                        <div class="w-1/2 font-medium">Email</div>
                        <div class="w-1/2">{{$user->email}}</div>
                    </div>
                    <div class="flex w-full">
                        <div class="w-1/2 font-medium">Phone number</div>
                        <div class="w-1/2">{{$user->phone}}</div>
                    </div>
                    <div class="flex w-full">
                        <div class="w-1/2 font-medium">Loan date</div>
                        <div class="w-1/2">{{$loan->loan_date}}</div>
                    </div>
                    @if (isset($loan->pickup_date))
                    <div class="flex w-full">
                        <div class="w-1/2 font-medium">Pickup date</div>
                        <div class="w-1/2">{{$loan->pickup_date}}</div>
                    </div>
                    @endif
                    @if (isset($loan->return_date))
                    <div class="flex w-full">
                        <div class="w-1/2 font-medium">Return date</div>
                        <div class="w-1/2">{{$loan->return_date}}</div>
                    </div>
                    @endif
                    <div class="flex w-full">
                        <div class="w-1/2 font-medium">Due date</div>
                        <div class="w-1/2">{{$loan->due_date}}</div>
                    </div>
                    <div class="flex w-full">
                        <div class="w-1/2 font-medium">Status</div>
                        <select onchange="changeStatus(this)" name="status" id="status" class="border border-black rounded" @php if ($loan->status == "Đã trả sách") echo "disabled" @endphp>
                            <option value="Chờ nhận sách" @php echo ($loan->status == "Chờ nhận sách") ? "selected" : "hidden" @endphp>Chờ nhận sách</option>
                            <option value="Chưa trả sách" @php if ($loan->status == "Chưa trả sách") echo "selected" @endphp>Chưa trả sách</option>
                            <option value="Đã trả sách" @php if ($loan->status == "Đã trả sách") echo "selected" @endphp>Đã trả sách</option>
                        </select>
                        <script>
                            function changeStatus(page) {
                                if (confirm("Are you sure?")) {
                                    page.form.submit();
                                }
                            }
                        </script>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
@endsection
@extends('layout')

@section('content')
<div class="p-2 sm:p-4 w-full">
    <div class="w-full">
        <div class="w-full mb-6">
            <form action="/notification/store" method="POST" class="@php
                echo (auth()->guard('admin')->user()->create_admin) ? "" : "hidden"
            @endphp">
                @csrf
                <div class="font-semibold text-xl mb-1">Post new notification</div>
                <textarea name="content" id="content" class="w-full border border-black rounded p-1" rows="6"></textarea>
                <div class="flex justify-end">
                    <button class="rounded-md bg-slate-200 hover:opacity-70 px-4 py-2">Post</button>
                </div>
            </form>
        </div>
        <div class="w-full">
            <div class="w-full flex justify-between">
                <div class="font-semibold text-xl mb-1">Recent loans</div>
                <div><a href="/loan/list" class="hover:underline text-blue-600">See all loans</a></div>
            </div>
            <table class="w-full border-collapse text-center border border-gray-500">
                <thead>
                    <tr>
                        <td class="border border-gray-500 font-semibold">ID</td>
                        <td class="border border-gray-500 font-semibold">Student_code</td>
                        <td class="border border-gray-500 font-semibold">Student name</td>
                        <td class="border border-gray-500 sm:w-[500px] font-semibold">Book title</td>
                        <td class="border border-gray-500 font-semibold">Loan date</td>
                        <td class="border border-gray-500 font-semibold">Status</td>
                        <td class="border border-gray-500"></td>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($loanList as $loan)
                        <tr class="border border-gray-300">
                            <td>{{$loan->id}}</td>
                            <td>{{$loan->user->student_code}}</td>
                            <td>{{$loan->user->student_name}}</td>
                            <td>{{$loan->book_title}}</td>
                            <td>{{$loan->loan_date}}</td>
                            <td>
                                <form action="/loan/update" method="POST">
                                    @csrf
                                    <input type="hidden" name="id" id="id" value="{{$loan->id}}">
                                    <select onchange="return changeStatus(this)" name="status" id="status" class="border border-black rounded" @disabled($loan->status == "Đã trả sách")>
                                        <option value="Chờ nhận sách" @php echo ($loan->status == "Chờ nhận sách") ? "selected" : "hidden" @endphp>Chờ nhận sách</option>
                                        <option value="Chưa trả sách" @selected($loan->status == "Chưa trả sách")>Chưa trả sách</option>
                                        <option value="Đã trả sách" @selected($loan->status == "Đã trả sách")>Đã trả sách</option>
                                    </select>
                                    <script>
                                        function changeStatus(page) {
                                            if (confirm("Are you sure?")) {
                                                page.form.submit();
                                            }
                                        }
                                    </script>
                                </form>
                            </td>
                            <td><a href="/loan/{{$loan->id}}" target="_blank" class="text-blue-600 hover:underline">Details</a></td>
                        </tr>
                    @endforeach
                    
                </tbody>
            </table>
            @if ($loanList->count() == 0)
                <div class="w-full text-center text-xl font-medium">No loans found</div>
            @endif
        </div>
        <div class="w-full mt-5">
            <div class="font-semibold text-xl mb-1">Most loaned books</div>
            <div class="flex flex-wrap gap-2">
                @foreach ($bookList as $book)
                    <div class="flex border w-full sm:w-[46%] md:w-[31%] border-slate-800 rounded p-1 sm:p-2">
                        <img src="{{$book->cover}}" alt="" class="w-24">
                        <div class="ml-2">
                            <div class="font-medium text-xl hover:underline max-h-14 overflow-hidden"><a target="_blank" href="/book/{{$book->id}}">{{$book->title}}</a></div>
                            <div>by {{$book->author}}</div>
                            <div>Major: {{$book->major}}</div>
                            <div>Loaned {{$book->loans_count}} times</div>
                            <div><a href="/loan/list?book_id={{$book->id}}" target="_blank" class="text-blue-600 hover:underline">Loans</a></div>
                        </div>
                    </div>
                @endforeach
            </div>
        </div>
    </div>
</div>
@endsection
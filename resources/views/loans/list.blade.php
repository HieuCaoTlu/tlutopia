@extends('layout')

@section('content')

<div class="p-2 sm:p-4 w-full">
    <div class="w-full">
        <div class="mb-4 flex justify-between">
            <div class="font-semibold text-xl ">All loans</div>
            <form action="/loan/list" method="GET">
                <input type="text" id="query" name="query" class="border border-gray-500 rounded h-8 px-2" placeholder="Search...">
                <select name="type" id="type" class="border border-gray-500 rounded h-8">
                    <option value="student">By student</option>
                    <option value="book">By book</option>
                </select>
            </form>
        </div>
        
        <div class="w-full">
            <table class="w-full border-collapse text-center border border-gray-500">
                <thead>
                    <tr>
                        <td class="border border-gray-500 font-semibold">ID</td>
                        <td class="border border-gray-500 font-semibold">
                            @if (isset($sortby) && $sortby == "student_code" && $order == "desc")
                                <a href="/loan/list?sortby=student_code&order=asc" class="hover:underline">Student code &#8595;</a>
                            @else
                                <a href="/loan/list?sortby=student_code&order=desc" class="hover:underline">Student code &#8593;</a>
                            @endif
                        </td>
                        <td class="border border-gray-500 font-semibold">Student name</td>
                        <td class="border border-gray-500 sm:w-[500px] font-semibold">Book title</td>
                        <td class="border border-gray-500 font-semibold">
                            @if (isset($sortby) && $sortby == "loan_date" && $order == "asc")
                                <a href="/loan/list?sortby=loan_date&order=desc" class="hover:underline">Loan date &#8593;</a>
                            @else
                                <a href="/loan/list?sortby=loan_date&order=asc" class="hover:underline">Loan date &#8595;</a>
                            @endif
                            
                        </td>
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
            @if ($loanList->total() == 0)
                <div class="w-full text-center text-xl font-medium">No loans found</div>
            @endif
            <div class="mt-3">{{$loanList->links()}}</div>
        </div>
    </div>
</div>

@endsection
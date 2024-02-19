@extends('layout')

@section('content')

<div class="p-2 sm:p-4 w-full">
    <div class="w-full">
        <div class="mb-4 flex justify-between">
            <div class="font-semibold text-xl ">All loans</div>
        </div>
        
        <div class="w-full">
            <table class="w-full border-collapse text-center border border-gray-500">
                <thead>
                    <tr>
                        <td class="border border-gray-500 overflow-hidden font-semibold">ID</td>
                        <td class="border border-gray-500 overflow-hidden font-semibold">Student code</td>
                        <td class="border border-gray-500 overflow-hidden font-semibold">Student name</td>
                        <td class="border border-gray-500 overflow-hidden font-semibold">Book title</td>
                        <td class="border border-gray-500 overflow-hidden font-semibold">Loan date</td>
                        <td class="border border-gray-500 overflow-hidden font-semibold">Status</td>
                        <td class="border border-gray-500"></td>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($loanList as $loan)
                        <tr>
                            <td>{{$loan->id}}</td>
                            <td>{{$loan->user->student_code}}</td>
                            <td>{{$loan->user->student_name}}</td>
                            <td>{{$loan->book->title}}</td>
                            <td>{{$loan->loan_date}}</td>
                            <td>
                                <form action="/loan/update" method="POST">
                                    @csrf
                                    <input type="hidden" name="id" id="id" value="{{$loan->id}}">
                                    <select onchange="return changeStatus(this)" name="status" id="status" class="border border-black rounded" @php if ($loan->status == "Đã trả sách") echo "disabled" @endphp>
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
                                </form>
                            </td>
                            <td><a href="/loan/{{$loan->id}}" target="_blank" class="text-blue-600 hover:underline">Details</a></td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
            <div class="mt-3">{{$loanList->links()}}</div>
        </div>
    </div>
</div>

@endsection
@extends('layout')

@section('content')
<div class="p-2 sm:p-4 w-full">
    <div class="w-full">
        <div class="font-semibold text-xl mb-4">Loans</div>
        <div class="w-full">
            <table class="w-full border-collapse text-center">
                <thead>
                    <tr>
                        <td class="border border-gray-500">Loan ID</td>
                        <td class="border border-gray-500">Book ID</td>
                        <td class="border border-gray-500">Student ID</td>
                        <td class="border border-gray-500">Loan date</td>
                        <td class="border border-gray-500">Status</td>
                        <td class="border border-gray-500"></td>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
</div>
@endsection
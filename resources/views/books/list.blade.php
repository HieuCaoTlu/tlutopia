@extends('layout')

@section('content')
<div class="p-2 sm:p-4 w-full">
    <div class="w-full">
        <div class="mb-4 flex justify-between">
            <div class="font-semibold text-xl ">All books</div>
            <button class="rounded-md bg-slate-200 hover:opacity-70 px-4 py-2" onclick="openAddBook()">Add book</button>
        </div>
        
        <div class="w-full">
            <table class="w-full border-collapse text-center border border-gray-500">
                <thead>
                    <tr>
                        <td class="border border-gray-500 w-[80px] overflow-hidden">ID</td>
                        <td class="border border-gray-500 w-[500px] overflow-hidden">Title</td>
                        <td class="border border-gray-500 w-[250px] overflow-hidden">Author</td>
                        <td class="border border-gray-500 w-[250px] overflow-hidden">Major</td>
                        <td class="border border-gray-500 w-[100px] overflow-hidden">Quantity</td>
                        <td class="border border-gray-500"></td>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($bookList as $book)
                        <tr>
                            <td>{{$book->id}}</td>
                            <td>{{$book->title}}</td>
                            <td>{{$book->author}}</td>
                            <td>{{$book->major}}</td>
                            <td>{{$book->quantity}}</td>
                            <td><a href="" class="text-blue-600 hover:underline">Details</a></td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
</div>

<div id="add-book-overlay" class="hidden fixed top-0 left-0 bg-black bg-opacity-70 h-full w-full items-center justify-center">
    <div id="add-book-modal" class="h-[80%] w-[80%] bg-white rounded-md">

    </div>
</div>
<script>
    const overlay = document.getElementById("add-book-overlay");
    overlay.addEventListener('click', function(event) {
        const targetElement = event.target;
        
        const modal = document.getElementById("add-book-modal");
        if (!modal.contains(targetElement) && overlay.style.display !== "none") {
            overlay.style.display = "none";
        }
    });

    function openAddBook() {
        overlay.style.display = "flex";
    }
</script>
@endsection
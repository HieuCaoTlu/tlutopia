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
                        <td class="border border-gray-500 sm:w-[80px] overflow-hidden">ID</td>
                        <td class="border border-gray-500 sm:w-[500px] overflow-hidden">Title</td>
                        <td class="border border-gray-500 sm:w-[250px] overflow-hidden">Author</td>
                        <td class="border border-gray-500 sm:w-[250px] overflow-hidden">Major</td>
                        <td class="border border-gray-500 sm:w-[100px] overflow-hidden">Quantity</td>
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
    <div id="add-book-modal" class="h-full w-full sm:h-[80%] sm:w-[80%] bg-white rounded-md relative p-5">
        <button class="absolute top-3 right-4" onclick="closeAddBook()">&#x2715;</button>
        <div class="text-xl font-semibold border-b border-b-gray-400 h-10">Add a new book</div>
        <form action="/book/store" method="post" class="mt-5 w-full h-[calc(100%-40px)] overflow-y-auto ">
            @csrf
            <div class="w-full lg:flex lg:justify-center lg:gap-10 lg:mt-10">
                <div>
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="title" class="inline-block w-[100px]">Title</label>
                        <input type="text" id="title" name="title" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full">
                        @error('title')
                            <div class="text-red-500 text-sm">{{$message}}</div>
                        @enderror
                    </div>
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="author" class="inline-block w-[100px]">Author</label>
                        <input type="text" id="author" name="author" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full">
                        @error('author')
                            <div class="text-red-500 text-sm">{{$message}}</div>
                        @enderror
                    </div>
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="major" class="inline-block w-[100px]">Major</label>
                        <input type="text" id="major" name="major" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full">
                        @error('major')
                            <div class="text-red-500 text-sm">{{$message}}</div>
                        @enderror
                    </div>
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="author" class="inline-block w-[100px]">Description</label>
                        <textarea type="text" id="description" name="description" rows="3" class="border border-black px-2 py-1 md:w-[calc(100%-100px)] rounded-md"></textarea>
                        @error('description')
                            <div class="text-red-500 text-sm">{{$message}}</div>
                        @enderror
                    </div>
                </div>
                <div>
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="major" class="inline-block w-[100px]">Publish date</label>
                        <input type="date" id="publish_date" name="publish_date" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full">
                        @error('publish_date')
                            <div class="text-red-500 text-sm">{{$message}}</div>
                        @enderror
                    </div>
                    <div class="w-[400px] flex items-center mb-4">
                        <label for="major" class="inline-block w-[100px]">Quantity</label>
                        <input type="number" id="quantity" name="quantity" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full">
                        @error('quantity')
                            <div class="text-red-500 text-sm">{{$message}}</div>
                        @enderror
                    </div>
                    <div class="w-[400px] flex items-center mb-4">
                        <label for="major" class="inline-block w-[100px]">Cover link</label>
                        <input type="text" id="cover" name="cover" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full">
                        @error('cover')
                            <div class="text-red-500 text-sm">{{$message}}</div>
                        @enderror
                    </div>
                </div>
            </div>
            <div class="w-full flex justify-center mt-5">
                <button type="submit" class="border border-black rounded-full w-24 h-12 mb-3">Save</button>
            </div>
            
        </form>
    </div>
</div>
<div id="update-book-overlay" class="hidden fixed top-0 left-0 bg-black bg-opacity-70 h-full w-full items-center justify-center">
    <div id="update-book-modal" class="h-full w-full sm:h-[80%] sm:w-[80%] bg-white rounded-md relative p-5">
        <button class="absolute top-3 right-4" onclick="closeUpdateBook()">&#x2715;</button>
        <div class="text-xl font-semibold border-b border-b-gray-400 h-10">Book details</div>
        <form action="/book/update" method="post" class="mt-5 w-full h-[calc(100%-40px)] overflow-y-auto ">
            @csrf
            <div class="w-full lg:flex lg:justify-center lg:gap-10 lg:mt-10">
                <div>
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="title" class="inline-block w-[100px]">Title</label>
                        <input type="text" id="title" name="title" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full">
                        @error('title')
                            <div class="text-red-500 text-sm">{{$message}}</div>
                        @enderror
                    </div>
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="author" class="inline-block w-[100px]">Author</label>
                        <input type="text" id="author" name="author" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full">
                        @error('author')
                            <div class="text-red-500 text-sm">{{$message}}</div>
                        @enderror
                    </div>
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="major" class="inline-block w-[100px]">Major</label>
                        <input type="text" id="major" name="major" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full">
                        @error('major')
                            <div class="text-red-500 text-sm">{{$message}}</div>
                        @enderror
                    </div>
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="author" class="inline-block w-[100px]">Description</label>
                        <textarea type="text" id="description" name="description" rows="3" class="border border-black px-2 py-1 md:w-[calc(100%-100px)] rounded-md"></textarea>
                        @error('description')
                            <div class="text-red-500 text-sm">{{$message}}</div>
                        @enderror
                    </div>
                </div>
                <div>
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="major" class="inline-block w-[100px]">Publish date</label>
                        <input type="date" id="publish_date" name="publish_date" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full">
                        @error('publish_date')
                            <div class="text-red-500 text-sm">{{$message}}</div>
                        @enderror
                    </div>
                    <div class="w-[400px] flex items-center mb-4">
                        <label for="major" class="inline-block w-[100px]">Quantity</label>
                        <input type="number" id="quantity" name="quantity" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full">
                        @error('quantity')
                            <div class="text-red-500 text-sm">{{$message}}</div>
                        @enderror
                    </div>
                    <div class="w-[400px] flex items-center mb-4">
                        <label for="major" class="inline-block w-[100px]">Cover link</label>
                        <input type="text" id="cover" name="cover" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full">
                        @error('cover')
                            <div class="text-red-500 text-sm">{{$message}}</div>
                        @enderror
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

    function closeAddBook() {
        overlay.style.display = "none";
    }
</script>
@endsection
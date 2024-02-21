@extends('layout')

@section('content')
<div class="h-full w-full flex items-center justify-center">
    <div class="h-full w-full sm:h-[80%] sm:w-[80%] border border-black bg-white rounded-md relative p-5 mt-10">
        <div class="text-xl font-semibold border-b border-b-gray-400 h-10">Book details</div>
        <form action="/book/update" method="post" class="mt-5 w-full h-[calc(100%-40px)] overflow-y-auto ">
            @csrf
            <input type="hidden" value="{{$book->id}}" id="id" name="id">
            <div class="w-full lg:flex lg:justify-center lg:gap-10 lg:mt-10">
                <div>
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="title" class="inline-block w-[100px]">Title</label>
                        <input type="text" id="title" name="title" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full" value="{{$book->title}}">
                    </div>
                    @error('title')
                        <div class="text-red-500 text-sm">{{$message}}</div>
                    @enderror
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="author" class="inline-block w-[100px]">Author</label>
                        <input type="text" id="author" name="author" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full" value="{{$book->author}}">
                    </div>
                    @error('author')
                        <div class="text-red-500 text-sm">{{$message}}</div>
                    @enderror
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="major" class="inline-block w-[100px]">Major</label>
                        <input type="text" id="major" name="major" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full" value="{{$book->major}}">                        
                    </div>
                    @error('major')
                        <div class="text-red-500 text-sm">{{$message}}</div>
                    @enderror
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="author" class="inline-block w-[100px]">Description</label>
                        <textarea type="text" id="description" name="description" rows="3" class="border border-black px-2 py-1 md:w-[calc(100%-100px)] rounded-md">{{$book->description}}</textarea>
                    </div>
                    @error('description')
                        <div class="text-red-500 text-sm">{{$message}}</div>
                    @enderror
                </div>
                <div>
                    <div class="md:w-[400px] flex items-center mb-4">
                        <label for="major" class="inline-block w-[100px]">Publish date</label>
                        <input type="date" id="publish_date" name="publish_date" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full" value="{{$book->publish_date}}">
                    </div>
                    @error('publish_date')
                        <div class="text-red-500 text-sm">{{$message}}</div>
                    @enderror
                    <div class="w-[400px] flex items-center mb-4">
                        <label for="major" class="inline-block w-[100px]">Quantity</label>
                        <input type="number" id="quantity" name="quantity" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full" value="{{$book->quantity}}">
                    </div>
                    @error('quantity')
                        <div class="text-red-500 text-sm">{{$message}}</div>
                    @enderror
                    <div class="w-[400px] flex items-center mb-4">
                        <label for="major" class="inline-block w-[100px]">Cover link</label>
                        <input type="text" id="cover" name="cover" class="border border-black py-2 px-4 md:w-[calc(100%-100px)] rounded-full" value="{{$book->cover}}">
                    </div>
                    @error('cover')
                        <div class="text-red-500 text-sm">{{$message}}</div>
                    @enderror
                    <div class="flex justify-center">
                        <img class="w-20 shadow-black shadow-lg" src="{{$book->cover}}" alt="">
                    </div>
                </div>
            </div>
            <div class="w-full flex justify-center mt-5">
                <button type="submit" class="border border-black rounded-full w-24 h-12 mb-3">Save</button>
            </div>
        </form>
    </div>
</div>
@endsection
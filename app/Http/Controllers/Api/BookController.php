<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Book;

class BookController extends Controller
{
    public function index()
{
    return Book::all();
}

public function store(Request $request)
{
    $book = Book::create($request->all());

    return response()->json($book, 201);
}

public function show(Book $book)
{
    return response()->json($book);
}

public function update(Request $request, Book $book)
{
    $book->update($request->all());

    return response()->json($book);
}

public function destroy(Book $book)
{
    $book->delete();

    return response()->json(null, 204);
}
}

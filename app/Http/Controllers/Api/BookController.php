<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Book;

class BookController extends Controller
{
    public function index()
    {
        return response()->json(Book::all());
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

    public function newest(Request $request) {
        $major = $request->input('major', "");
        $amount = request()->input('amount', 5);
        $query = Book::orderBy('publish_date', 'desc');

        if ($major != "") {
            $query->where('major', $major);
        }

        $randomBooks = $query->limit($amount)->get();

        return response()->json($randomBooks);
    }

    public function random(Request $request) {
        $major = $request->input('major', "");
        $amount = request()->input('amount', 5);

        $query = Book::inRandomOrder();

        if ($major != "") {
            $query->where('major', $major);
        }

        $randomBooks = $query->limit($amount)->get();

        return response()->json($randomBooks);
    }
}

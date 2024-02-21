<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Book;
use Mockery\Undefined;

class BookController extends Controller
{
    public function list(Request $request) {
        $query = $request['query'];
        if ($query != null) {
            $books = Book::where($request['type'], 'LIKE', "%{$query}%")->paginate(10);
        } else {
            $books = Book::paginate(10);
        }
        return view('books.list', [
            'bookList' => $books
        ]);
    }

    public function store(Request $request) {
        $formFields = $request->validate([
            'title' => 'required',
            'author' => 'required',
            'major' => 'required',
            'description' => 'required',
            'publish_date' => 'required',
            'cover' => 'required'
        ]);
        if (!$request->input('quantity')) 
            $formFields['quantity'] = 0;
        else 
            $formFields['quantity'] = $request->input('quantity');
        Book::create($formFields);
        return redirect()->back();
    }

    public function show(Book $book) {
        return view('books.show', [
            'book' => $book
        ]);
    }

    public function update(Request $request) {
        $book = Book::find($request->input('id'));
        $formFields = $request->validate([
            'title' => 'required',
            'author' => 'required',
            'major' => 'required',
            'description' => 'required',
            'publish_date' => 'required',
            'quantity' => 'required',
            'cover' => 'required'
        ]);
        $book->update($formFields);
        return redirect('/book/list');
    }

    public function delete(Request $request) {
        $book = Book::find($request->input('id'));
        $book->delete();
        return redirect()->back()->with('message', 'Book deleted.');
    }
}

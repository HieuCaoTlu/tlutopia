<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Book;

class BookController extends Controller
{
    public function list() {
        return view('books.list', [
            'bookList' => Book::paginate(10)
        ]);
    }

    public function store(Request $request) {
        //dd($request);
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
}

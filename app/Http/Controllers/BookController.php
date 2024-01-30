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
}

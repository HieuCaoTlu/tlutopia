<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\BookController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function() {
    if (auth()->guard('admin')->check()) {
        return view('admin.dashboard');
    }
    return redirect('/admin/login');
});

Route::get('/admin/login', [AdminController::class, 'login']);

Route::post('/admin/authenticate', [AdminController::class, 'authenticate']);

Route::get('/book/list', [BookController::class, 'list']);

Route::post('/book/store', [BookController::class, 'store']);

Route::post('/book/update', [BookController::class, 'update']);
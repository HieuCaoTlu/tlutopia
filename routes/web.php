<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\NotifyController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\LoanController;
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
        return redirect('/dashboard');
    }
    return redirect('/admin/login');
});

Route::get('/dashboard' , [AdminController::class, 'dashboard']);

Route::get('/admin/login', [AdminController::class, 'login']);

Route::post('/admin/authenticate', [AdminController::class, 'authenticate']);

Route::post('/admin/logout', [AdminController::class, 'logout']);

Route::get('/admin/list', [AdminController::class, 'list']);

Route::post('/admin/store', [AdminController::class, 'store']);

Route::post('/admin/update', [AdminController::class, 'update']);

Route::get('/book/list', [BookController::class, 'list']);

Route::get('/book/{book}', [BookController::class, 'show']);

Route::post('/book/store', [BookController::class, 'store']);

Route::post('/book/update', [BookController::class, 'update']);

Route::post('/book/delete', [BookController::class, 'delete']);

Route::get('/loan/list', [LoanController::class, 'list']);

Route::get('/loan/{loan}', [LoanController::class, 'show']);

Route::post('/loan/update', [LoanController::class, 'changeStatus']);

Route::get('/user/list', [UserController::class, 'list']);

Route::get('/notification/list', [NotifyController::class, 'list']);

Route::post('/notification/store', [NotifyController::class, 'store']);


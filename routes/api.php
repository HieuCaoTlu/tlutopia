<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('login', [Api\UserController::class, 'authenticate']);

Route::get('users', [Api\UserController::class, 'index']);
Route::post('users', [Api\UserController::class, 'store']);
Route::get('users/{user}', [Api\UserController::class, 'show']);
Route::put('users/{user}', [Api\UserController::class, 'update']);
Route::delete('users/{user}', [Api\UserController::class, 'destroy']);

Route::get('books', [Api\BookController::class, 'index']);
//Route::post('books', [Api\BookController::class, 'store']);
Route::get('books/random', [Api\BookController::class, 'random']);
Route::get('books/newest', [Api\BookController::class, 'newest']);
Route::get('books/{book}', [Api\BookController::class, 'show']);
//Route::put('books/{book}', [Api\BookController::class, 'update']);
//Route::delete('books/{book}', [Api\BookController::class, 'destroy']);

Route::get('loans', [Api\LoanController::class, 'index']);
Route::post('loans', [Api\LoanController::class, 'store']);
Route::get('loans/{loan}', [Api\LoanController::class, 'show']);
//Route::put('loans/{loan}', [Api\LoanController::class, 'update']);
//Route::delete('loans/{loan}', [Api\LoanController::class, 'destroy']);

Route::get('notifications', [Api\NotifyController::class, 'index']);
Route::post('notifications', [Api\NotifyController::class, 'store']);
Route::get('notifications/{notify}', [Api\NotifyController::class, 'show']);
Route::put('notifications/{notify}', [Api\NotifyController::class, 'update']);
//Route::delete('notification/{notify}', [Api\NotifyController::class, 'destroy']);
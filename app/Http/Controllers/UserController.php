<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function list() {
        return view('users.list', [
            'userList' => User::paginate(10)
        ]);
    }
}

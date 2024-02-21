<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function list(Request $request) {
        $query = $request['query'];
        if ($query != null) {
            if ($request['user']) {
                $users = User::where('student_code', $query)->paginate(10);
            } else {
                $users = User::where('student_code', 'LIKE', "%{$query}%")
                            ->orWhere('student_name', 'LIKE', "%{$query}%")
                            ->paginate(10);
            }
        } else {
            $users = User::paginate(10);
        }
        return view('users.list', [
            'userList' => $users
        ]);
    }
}

<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;

class UserController extends Controller
{
    public function authenticate(Request $request) {
        $formFields = $request->validate([
            'student_code' => 'required',
            'password' => 'required'
        ]);

        if (!auth()->attempt($formFields)) {
            return response()->json([
                'message' => "Sai mã sinh viên hoặc mật khẩu"
            ], 401);
        }

        return response()->json([
            'message' => "Đăng nhập thành công"
        ]);
        
    }

    public function index()
    {
        return User::all();
    }

    public function store(Request $request)
    {
        $user = User::create($request->all());

        return response()->json($user, 201);
    }

    public function show(User $user)
    {
        return response()->json($user);
    }

    public function update(Request $request, User $user)
    {
        $user->update($request->all());

        return response()->json($user);
    }

    public function destroy(User $user)
    {
        $user->delete();

        return response()->json(null, 204);
    }
}

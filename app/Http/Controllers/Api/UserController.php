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

        return response()->json(auth()->user());
        
    }

    public function index()
    {
        return User::all();
    }

    public function store(Request $request)
    {
        try {
            $formFields = $request->validate([
                'student_name' => 'required',
                'student_code' => 'required',
                'phone' => 'required',
                'email' => 'required|email',
                'password' => 'required',
            ]);
            $formFields['status'] = 'active';
            $formFields['password'] = bcrypt($formFields['password']);
            $user = User::create($formFields);

            return response()->json($user, 201);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Failed to create user. ' . $e->getMessage()
            ], 400);
        }
    }

    public function show(User $user)
    {
        return response()->json($user);
    }

    public function update(Request $request, User $user)
    {
        try {
            $user->update($request->all());
            return response()->json($user);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Error updating user. '. $e->getMessage()
            ]);
        }
    }

    public function destroy(User $user)
    {
        $user->delete();

        return response()->json(null, 204);
    }
}

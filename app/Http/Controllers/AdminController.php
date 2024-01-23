<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class AdminController extends Controller
{
    public function login(){
        return view('admin.login');
    }

    public function authenticate(Request $request) {
        $formFields = $request->validate([
            'username' => 'required',
            'password' => 'required'
        ]);

        if (auth()->guard('admin')->attempt($formFields, isset($request['remember']))) {
            $request->session()->regenerate();
            return redirect('/');
        }

        return back()->withErrors(['username' => 'Incorrect username or password.']);
    }
 
    public function logout(Request $request)
    {

    }
}

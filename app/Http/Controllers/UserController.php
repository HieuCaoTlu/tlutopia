<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class UserController extends Controller
{
    public function authenticate(Request $request) {
        $formFields = $request->validate([
            'username' => 'required',
            'password' => 'required'
        ]);

        if (auth()->attempt($formFields, isset($request['remember']))) {
            $request->session()->regenerate();
            return redirect('/');
        }

        return back()->withErrors(['username' => 'Incorrect username or password.']);
    }
}

<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Admin;

class AdminController extends Controller
{
    public function login(){
        if (auth()->guard('admin')->check())
            return redirect("/");
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
        auth()->guard('admin')->logout();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return redirect('/');
    }

    public function list() {
        return view('admin.list', [
            'adminList' => Admin::paginate(10)
        ]);
    }

    public function store(Request $request) {
        $formFields = $request->validate([
            'username' => 'required',
            'password' => 'required',
            'title' => 'required'
        ]);

        $formFields['create_admin'] = isset($request['create_admin']);
        $formFields['created_at'] = date('Y/m/d h:i:s', time());
        $formFields['password'] = bcrypt($formFields['password']);

        Admin::create($formFields);

        return redirect()->back();
    }
}

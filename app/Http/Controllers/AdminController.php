<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Admin;
use App\Models\Loan;
use App\Models\Book;
use Exception;

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

        try {
            Admin::create($formFields);
        } catch (Exception $e) {
            return redirect()->back()->with('message', "Failed creating admin. ".$e->getMessage());
        }

        return redirect()->back()->with('message', "Successfully created an admin.");
    }

    public function update(Request $request) {
        $account = Admin::find($request->input('id'));
        $account->update([
            'create_admin' => ($request->input('privileges')) ? true : false
        ]);
        return redirect()->back()->with('message', 'Privileges updated.');
    }

    public function dashboard() {
        $lastestLoans = Loan::orderBy('loan_date', 'desc')->limit(5)->get();
        $books = Book::withCount('loans')
                ->orderBy('loans_count', 'desc')
                ->limit(5)
                ->get();
        return view('admin.dashboard', [
            'bookList' => $books,
            'loanList' => $lastestLoans
        ]);
    }
}

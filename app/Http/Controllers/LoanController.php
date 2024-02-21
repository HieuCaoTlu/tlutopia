<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Loan;

class LoanController extends Controller
{
    public function list(Request $request) {
        $query = $request['query'];
        if ($query != null) {
            if ($request['type'] == 'student') {
                $loans = Loan::whereHas('user', function ($user) use ($query) {
                    $user->where('student_code', 'LIKE', "%{$query}%")
                        ->orWhere('student_name', 'LIKE', "%{$query}%");
                });
            } else {
                $loans = Loan::where('book_title', 'LIKE', "%{$query}%");
            }
        } else {
            $loans = Loan::orderBy('loan_date');
        }
        return view('loans.list', [
            'loanList' => $loans->paginate(10)
        ]);
    }

    public function show(Loan $loan) {
        return view('loans.show', [
            'loan' => $loan
        ]);
    }

    public function changeStatus(Request $request) {
        $loan = Loan::find($request->input('id'));
        $formFields = [
            'status' => $request->input('status')
        ];
        
        if ($request->input('status') == "Chưa trả sách") {
            $formFields['pickup_date'] = date('Y/m/d', time());
        }
        if ($request->input('status') == "Đã trả sách") {
            $formFields['return_date'] = date('Y/m/d', time());
        }
        $loan->update($formFields);
        return redirect()->back()->with('message', 'Loan updated.');
    }
}

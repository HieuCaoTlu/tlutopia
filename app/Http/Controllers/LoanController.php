<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Loan;

class LoanController extends Controller
{
    public function list() {
        return view('loans.list', [
            'loanList' => Loan::orderBy('loan_date')->paginate(10)
        ]);
    }

    public function show(Loan $loan) {
        return view('loans.show', [
            'loan' => $loan
        ]);
    }

    public function changeStatus(Request $request) {
        $loan = Loan::find($request->input('id'));
        $loan->update([
            'status' => $request->input('status')
        ]);
        return redirect()->back();
    }
}

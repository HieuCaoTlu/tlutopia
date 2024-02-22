<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Loan;

class LoanController extends Controller
{
    public function list(Request $request) {
        $query = $request['query'];
        $sortby = $request['sortby'];
        $order = $request['order'];

        $loans = Loan::orderBy('loan_date');
        
        if ($query != null) {
            if ($request['type'] == 'student') {
                $loans = $loans->whereHas('user', function ($user) use ($query) {
                    $user->where('student_code', 'LIKE', "%{$query}%")
                        ->orWhere('student_name', 'LIKE', "%{$query}%");
                });
            } else {
                $loans = $loans->where('book_title', 'LIKE', "%{$query}%");
            }
        }

        if ($sortby && $order) {
            if ($sortby == 'student_code') {
                $loans = $loans->join('user', 'user.id', '=', 'loan.user_id')
                            ->orderBy('user.student_code', $order)
                            ->select('loan.*');
            } else {
                $loans = $loans->orderBy($sortby, $order);
            }
        } 
        
        if ($request['user_id']) {
            $loans = Loan::where('user_id', $request['user_id']);
        }

        if ($request['book_id']) {
            $loans = Loan::where('book_id', $request['book_id']);
        }

        return view('loans.list', [
            'loanList' => $loans->paginate(10),
            'sortby' => $sortby,
            'order' => $order
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

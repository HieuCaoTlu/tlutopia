<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Loan;
use Illuminate\Http\Request;
use Carbon\Carbon;

class LoanController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        if ($request->has('user_id')) {
            return response()->json(Loan::where('user_id', $request->input('user_id'))->get());
        }
        return response()->json(Loan::all());
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        try {
            $formFields = $request->validate([
                'book_id' => 'required',
                'user_id' => 'required',
            ]);
            $formFields['loan_date'] = date('Y/m/d', time());
            $formFields['return_date'] = null;
            $formFields['due_date'] = Carbon::parse($formFields['loan_date'])->addDays(14)->format('Y/m/d');
            $formFields['status'] = "Chờ nhận sách";

            $loan = Loan::create($formFields);

            return response()->json($loan, 201);
        } catch (\Exception $e) {
            return response()->json([
                'error'=> 'Failed creating loan. '. $e->getMessage()
            ], 400);
        }
        
    }

    /**
     * Display the specified resource.
     */
    public function show(Loan $loan)
    {
        //
        return response()->json($loan);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Loan $loan)
    {
        //
        try {
            $loan->update($request->all());
            return response()->json($loan);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Error updating loan. '. $e->getMessage()
            ]);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Loan $loan)
    {
        //
    }
}

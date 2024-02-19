<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Notification;
use Illuminate\Http\Request;
use Carbon\Carbon;

class NotifyController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        if ($request->has('user_id')) {
            return response()->json(Notification::where('user_id', $request->input('user_id'))->get());
        }
        return response()->json(Notification::all());
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        try {
            $formFields = $request->validate([
                'user_id' => 'required',
                'content'=> 'required'
            ]);
            $formFields['date_created'] = date('Y/m/d h:i:s', time());

            $loan = Notification::create($formFields);

            return response()->json($loan, 201);
        } catch (\Exception $e) {
            return response()->json([
                'error'=> 'Failed creating notification. '. $e->getMessage()
            ], 400);
        }
        
    }

    /**
     * Display the specified resource.
     */
    public function show(Notification $notify)
    {
        //
        return response()->json($notify);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Notification $notify)
    {
        //
        try {
            $notify->update($request->all());
            return response()->json($notify);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Error updating notification. '. $e->getMessage()
            ]);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Notification $notify)
    {
        //
    }
}

<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Notification;
use Mockery\Undefined;

class NotifyController extends Controller
{
    public function list(Request $request) {
        return view('notifications.list', [
            'notificationList' => Notification::paginate(10)
        ]);
    }

    public function store(Request $request) {
        $admin = auth()->guard('admin')->user();
        $formFields = $request->validate([
            'content' => 'required'
        ]);
        $formFields['user_id'] = $admin->id;
        $formFields['date_created'] = date('Y/m/d h:i:s', time());
        Notification::create($formFields);
        return redirect("/notification/list")->with('message', "Notification posted");
    }

    public function show(Notification $notification) {
        
    }

    public function update(Request $request) {
        
    }

}

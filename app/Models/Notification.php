<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Notification extends Model
{
    protected $table = 'notification';
    use HasFactory;

    protected $fillable = [
        'user_id',
        'content',
        'date_created'
    ];

    public $timestamps = false;

    public function admin(): BelongsTo {
        return $this->belongsTo(Admin::class, 'user_id');
    }
}

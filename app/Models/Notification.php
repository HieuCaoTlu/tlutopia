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

    public function user(): BelongsTo {
        return $this->belongsTo(User::class, 'user_id');
    }
}

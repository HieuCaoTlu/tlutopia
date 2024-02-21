<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Loan extends Model
{
    protected $table = 'loan';
    public $timestamps = false;
    protected $fillable = [
        'user_id',
        'book_id',
        'book_title',
        'book_cover',
        'loan_date',
        'pickup_date',
        'return_date',
        'due_date',
        'status'
    ];
    use HasFactory;

    public function user() : BelongsTo {
        return $this->belongsTo(User::class, 'user_id');
    }
}

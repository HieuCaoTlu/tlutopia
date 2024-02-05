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
        'book_id',
        'user_id',
        'loan_date',
        'return_date',
        'due_date',
        'status'
    ];
    use HasFactory;

    public function book() : BelongsTo {
        return $this->belongsTo(Book::class, 'book_id');
    }

    public function user() : BelongsTo {
        return $this->belongsTo(User::class, 'user_id');
    }
}

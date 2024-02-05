<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Book extends Model
{
    protected $table = 'book';
    use HasFactory;

    protected $fillable = [
        'title',
        'author',
        'major',
        'description',
        'publish_date',
        'quantity',
        'cover'
    ];

    public $timestamps = false;

    public function loans(): HasMany {
        return $this->hasMany(Loan::class, 'book_id');
    }
}

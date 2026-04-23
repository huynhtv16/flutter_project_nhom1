<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Topic extends Model
{
    protected $fillable = [
        'title',
        'description',
        'cover_image',
    ];

    public function flashcards()
    {
        return $this->hasMany(Flashcard::class);
    }
}

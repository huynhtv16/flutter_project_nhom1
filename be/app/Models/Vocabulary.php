<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Vocabulary extends Model
{
    protected $fillable = [
        'word',
        'phonetic',
        'meaning',
        'examples',
        'image_url',
        'icon',
    ];

    protected $casts = [
        'examples' => 'array',
    ];
}

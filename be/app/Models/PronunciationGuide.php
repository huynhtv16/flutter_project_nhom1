<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PronunciationGuide extends Model
{
    protected $fillable = [
        'symbol',
        'sound',
        'description',
        'examples',
    ];

    protected $casts = [
        'examples' => 'array',
    ];
}

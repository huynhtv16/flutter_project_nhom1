<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LearningPath extends Model
{
    protected $fillable = [
        'title',
        'description',
        'steps', // json array of step descriptors
    ];

    protected $casts = [
        'steps' => 'array',
    ];
}

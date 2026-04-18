<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Exercise extends Model
{
    protected $fillable = [
        'title',
        'description',
        'type',
        'difficulty',
        'duration',
        'questions',
    ];

    protected $casts = [
        'questions' => 'array',
    ];

    public function attempts()
    {
        return $this->hasMany(ExerciseAttempt::class);
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ExerciseAttempt extends Model
{
    protected $fillable = [
        'user_id',
        'exercise_id',
        'score',
        'attempted_at',
    ];

    protected $casts = [
        'attempted_at' => 'datetime',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function exercise()
    {
        return $this->belongsTo(Exercise::class);
    }
}

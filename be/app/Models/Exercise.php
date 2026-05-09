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
        'course_id',
    ];

    protected $casts = [
        'questions' => 'array',
    ];

    public function attempts()
    {
        return $this->hasMany(ExerciseAttempt::class);
    }

    public function course()
    {
        return $this->belongsTo(Course::class);
    }
}

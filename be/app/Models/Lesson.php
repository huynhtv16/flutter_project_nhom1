<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Lesson extends Model
{
    protected $fillable = [
        'title',
        'description',
        'type',
        'vocabulary_ids',
        'phrase_ids',
        'exercise_ids',
        'pronunciation_ids',
    ];

    protected $casts = [
        'vocabulary_ids' => 'array',
        'phrase_ids' => 'array',
        'exercise_ids' => 'array',
        'pronunciation_ids' => 'array',
    ];

    public function vocabulary()
    {
        return $this->belongsToMany(Vocabulary::class, 'lesson_vocabulary');
    }

    public function phrases()
    {
        return $this->belongsToMany(Phrase::class, 'lesson_phrases');
    }

    public function exercises()
    {
        return $this->belongsToMany(Exercise::class, 'lesson_exercises');
    }

    public function quizzes()
    {
        return $this->hasMany(Quiz::class);
    }
}

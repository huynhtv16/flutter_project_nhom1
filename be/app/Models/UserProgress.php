<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserProgress extends Model
{
    protected $fillable = [
        'user_id',
        'learned_words',
        'quiz_scores',
        'total_score',
        'favorites',
        'claimed_rewards',
    ];

    protected $casts = [
        'learned_words' => 'array',
        'quiz_scores' => 'array',
        'favorites' => 'array',
        'claimed_rewards' => 'array',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}

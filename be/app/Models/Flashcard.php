<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Flashcard extends Model
{
    protected $fillable = [
        'topic_id',
        'front_text',
        'back_text',
        'example',
        'audio_url',
    ];

    public function topic()
    {
        return $this->belongsTo(Topic::class);
    }
}

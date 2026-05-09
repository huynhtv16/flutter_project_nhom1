<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ListeningItem extends Model
{
    protected $fillable = [
        'title',
        'text',
        'course_id',
    ];

    public function course()
    {
        return $this->belongsTo(Course::class);
    }
}

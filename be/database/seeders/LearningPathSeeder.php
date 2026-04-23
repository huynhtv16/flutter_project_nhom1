<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\LearningPath;

class LearningPathSeeder extends Seeder
{
    use WithoutModelEvents;

    public function run(): void
    {
        LearningPath::create([
            'title' => 'Beginner Path',
            'description' => 'Start with common vocabulary and simple listening',
            'steps' => [
                ['type' => 'topic', 'topic_id' => 1],
                ['type' => 'flashcards', 'topic_id' => 1],
                ['type' => 'listening', 'lesson_id' => 1],
            ],
        ]);
    }
}

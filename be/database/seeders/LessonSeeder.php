<?php

namespace Database\Seeders;

use App\Models\Lesson;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class LessonSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $lessons = [
            [
                'title' => 'Basic Greetings',
                'description' => 'Learn basic greeting words',
                'type' => 'vocabulary',
                'vocabulary_ids' => [1, 2, 3],
            ],
            [
                'title' => 'Animals',
                'description' => 'Learn animal vocabulary',
                'type' => 'vocabulary',
                'vocabulary_ids' => [4, 5],
            ],
            [
                'title' => 'Food and Drinks',
                'description' => 'Learn food and drink vocabulary',
                'type' => 'vocabulary',
                'vocabulary_ids' => [6, 7],
            ],
        ];

        foreach ($lessons as $lesson) {
            Lesson::create($lesson);
        }
    }
}

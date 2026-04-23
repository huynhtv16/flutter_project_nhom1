<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class CourseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        \App\Models\Course::create([
            'title' => 'Daily Conversation',
            'description' => 'Practice real-life phrases and dialogues for travel and daily life.',
            'lessons' => 8,
        ]);

        \App\Models\Course::create([
            'title' => 'Business English',
            'description' => 'Learn formal vocabulary, emails and meeting phrases.',
            'lessons' => 6,
        ]);

        \App\Models\Course::create([
            'title' => 'Listening Essentials',
            'description' => 'Improve listening skills with short audio lessons.',
            'lessons' => 5,
        ]);
    }
}

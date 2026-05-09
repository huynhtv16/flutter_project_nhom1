<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ExerciseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $daily = \App\Models\Course::where('title', 'Daily Conversation')->first();
        $business = \App\Models\Course::where('title', 'Business English')->first();
        $listening = \App\Models\Course::where('title', 'Listening Essentials')->first();

        \App\Models\Exercise::create([
            'title' => 'Basic Matching',
            'description' => 'Match the words with their meanings.',
            'type' => 'matching',
            'difficulty' => '2',
            'duration' => 5,
            'questions' => [
                [
                    'id' => 1,
                    'question' => 'Select the correct meaning of "apple"',
                    'options' => ['A fruit', 'A vehicle', 'A tool'],
                    'correctIndex' => 0,
                    'explanation' => 'Apple is a fruit.',
                    'hint' => 'It is edible',
                ],
                [
                    'id' => 2,
                    'question' => 'Select the correct meaning of "run"',
                    'options' => ['To walk slowly', 'To move fast on feet', 'To sleep'],
                    'correctIndex' => 1,
                    'explanation' => 'Run means to move quickly on foot.',
                    'hint' => 'Opposite of walk slowly',
                ],
            ],
            'course_id' => $daily ? $daily->id : null,
        ]);

        \App\Models\Exercise::create([
            'title' => 'Fill the Blank',
            'description' => 'Complete the sentence with the correct word.',
            'type' => 'fillblank',
            'difficulty' => '1',
            'duration' => 3,
            'questions' => [
                [
                    'id' => 3,
                    'question' => 'I ___ to school every day.',
                    'options' => ['go', 'went', 'gone'],
                    'correctIndex' => 0,
                    'explanation' => 'Present simple for routine.',
                    'hint' => 'Present tense',
                ],
            ],
            'course_id' => $business ? $business->id : ($listening ? $listening->id : null),
        ]);
    }
}

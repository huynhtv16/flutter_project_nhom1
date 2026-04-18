<?php

namespace Database\Seeders;

use App\Models\Quiz;
use App\Models\QuizQuestion;
use App\Models\QuizOption;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class QuizSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Create quiz for lesson 1
        $quiz = Quiz::create([
            'title' => 'Greetings Quiz',
            'lesson_id' => 1,
        ]);

        // Question 1
        $question1 = QuizQuestion::create([
            'quiz_id' => $quiz->id,
            'question' => 'What does "Hello" mean in Vietnamese?',
            'correct_answer_index' => 0,
            'explanation' => 'Hello means Xin chào in Vietnamese.',
        ]);

        QuizOption::create(['quiz_question_id' => $question1->id, 'option_text' => 'Xin chào', 'position' => 0]);
        QuizOption::create(['quiz_question_id' => $question1->id, 'option_text' => 'Tạm biệt', 'position' => 1]);
        QuizOption::create(['quiz_question_id' => $question1->id, 'option_text' => 'Cảm ơn', 'position' => 2]);

        // Question 2
        $question2 = QuizQuestion::create([
            'quiz_id' => $quiz->id,
            'question' => 'What does "Thank you" mean in Vietnamese?',
            'correct_answer_index' => 2,
            'explanation' => 'Thank you means Cảm ơn in Vietnamese.',
        ]);

        QuizOption::create(['quiz_question_id' => $question2->id, 'option_text' => 'Xin chào', 'position' => 0]);
        QuizOption::create(['quiz_question_id' => $question2->id, 'option_text' => 'Tạm biệt', 'position' => 1]);
        QuizOption::create(['quiz_question_id' => $question2->id, 'option_text' => 'Cảm ơn', 'position' => 2]);
    }
}

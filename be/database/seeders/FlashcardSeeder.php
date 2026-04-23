<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Flashcard;

class FlashcardSeeder extends Seeder
{
    use WithoutModelEvents;

    public function run(): void
    {
        // Create a few example flashcards (assumes topics exist with ids 1 and 2)
        Flashcard::create(['topic_id' => 1, 'front_text' => 'Hello', 'back_text' => 'Xin chào', 'example' => 'Hello, how are you?']);
        Flashcard::create(['topic_id' => 1, 'front_text' => 'Thank you', 'back_text' => 'Cảm ơn', 'example' => 'Thank you very much']);
        Flashcard::create(['topic_id' => 2, 'front_text' => 'Train', 'back_text' => 'Tàu hỏa', 'example' => 'The train is late']);
    }
}

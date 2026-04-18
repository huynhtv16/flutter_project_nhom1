<?php

namespace Database\Seeders;

use App\Models\Vocabulary;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class VocabularySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $vocabularies = [
            [
                'word' => 'Hello',
                'meaning' => 'Xin chào',
                'phonetic' => '/həˈloʊ/',
                'examples' => ['Hello, how are you?'],
                'image_url' => 'https://via.placeholder.com/600x300.png?text=Hello',
                'icon' => 'waving_hand',
            ],
            [
                'word' => 'Goodbye',
                'meaning' => 'Tạm biệt',
                'phonetic' => '/ˌɡʊdˈbaɪ/',
                'examples' => ['Goodbye, see you later.'],
                'image_url' => 'https://via.placeholder.com/600x300.png?text=Goodbye',
                'icon' => 'waving_hand',
            ],
            [
                'word' => 'Thank you',
                'meaning' => 'Cảm ơn',
                'phonetic' => '/ˈθæŋk juː/',
                'examples' => ['Thank you for your help.'],
                'image_url' => 'https://via.placeholder.com/600x300.png?text=Thank+you',
                'icon' => 'handshake',
            ],
            [
                'word' => 'Cat',
                'meaning' => 'Con mèo',
                'phonetic' => '/kæt/',
                'examples' => ['The cat is sleeping.'],
                'image_url' => 'https://via.placeholder.com/600x300.png?text=Cat',
                'icon' => 'pets',
            ],
            [
                'word' => 'Dog',
                'meaning' => 'Con chó',
                'phonetic' => '/dɔːɡ/',
                'examples' => ['I have a dog.'],
                'image_url' => 'https://via.placeholder.com/600x300.png?text=Dog',
                'icon' => 'pets',
            ],
            [
                'word' => 'Apple',
                'meaning' => 'Quả táo',
                'phonetic' => '/ˈæpəl/',
                'examples' => ['An apple a day keeps the doctor away.'],
                'image_url' => 'https://via.placeholder.com/600x300.png?text=Apple',
                'icon' => 'apple',
            ],
            [
                'word' => 'Car',
                'meaning' => 'Ô tô',
                'phonetic' => '/kɑːr/',
                'examples' => ['I go to work by car.'],
                'image_url' => 'https://via.placeholder.com/600x300.png?text=Car',
                'icon' => 'directions_car',
            ],
        ];

        foreach ($vocabularies as $vocab) {
            Vocabulary::create($vocab);
        }
    }
}

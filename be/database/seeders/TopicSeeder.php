<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Topic;

class TopicSeeder extends Seeder
{
    use WithoutModelEvents;

    public function run(): void
    {
        $t = Topic::create(["title" => "Basic Vocabulary", "description" => "Common everyday words"]);
        $t2 = Topic::create(["title" => "Travel", "description" => "Travel and transport vocabulary"]);
    }
}

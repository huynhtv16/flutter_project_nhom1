<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Reward;

class RewardSeeder extends Seeder
{
    use WithoutModelEvents;

    public function run(): void
    {
        Reward::create(['title' => 'Bronze Badge', 'description' => 'Earned after 10 words', 'points' => 10, 'icon' => 'bronze']);
        Reward::create(['title' => 'Silver Badge', 'description' => 'Earned after 50 words', 'points' => 50, 'icon' => 'silver']);
    }
}

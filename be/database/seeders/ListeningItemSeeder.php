<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ListeningItemSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $daily = \App\Models\Course::where('title', 'Daily Conversation')->first();
        $listening = \App\Models\Course::where('title', 'Listening Essentials')->first();

        \App\Models\ListeningItem::create([
            'title' => 'Greetings',
            'text' => 'Hello! How are you today?',
            'course_id' => $daily ? $daily->id : null,
        ]);

        \App\Models\ListeningItem::create([
            'title' => 'Shopping',
            'text' => 'Can I have a coffee, please?',
            'course_id' => $daily ? $daily->id : null,
        ]);

        \App\Models\ListeningItem::create([
            'title' => 'Travel',
            'text' => 'Where is the nearest train station?',
            'course_id' => $daily ? $daily->id : null,
        ]);

        \App\Models\ListeningItem::create([
            'title' => 'Restaurant Conversation',
            'text' => "Waiter: Good evening, would you like a table for two?\nCustomer: Yes please, near the window if possible.\nWaiter: Right this way.\nCustomer: Thank you.",
            'course_id' => $listening ? $listening->id : null,
        ]);

        \App\Models\ListeningItem::create([
            'title' => 'Phone Call',
            'text' => "A: Hi, are we still meeting at 3pm?\nB: Yes, I'll be there in 10 minutes.\nA: Great, see you then.",
            'course_id' => $listening ? $listening->id : null,
        ]);

        \App\Models\ListeningItem::create([
            'title' => 'At the Hotel',
            'text' => "Receptionist: Welcome to Sunny Hotel. Do you have a reservation?\nGuest: Yes, under the name Nguyen.\nReceptionist: Thank you, here's your key.",
            'course_id' => $listening ? $listening->id : null,
        ]);
    }
}

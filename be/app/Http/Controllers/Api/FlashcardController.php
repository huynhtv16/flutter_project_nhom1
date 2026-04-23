<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Flashcard;
use Illuminate\Http\Request;

class FlashcardController extends Controller
{
    public function index(Request $request)
    {
        $query = Flashcard::query();
        if ($request->has('topic_id')) {
            $query->where('topic_id', $request->topic_id);
        }
        return response()->json($query->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'topic_id' => 'required|integer|exists:topics,id',
            'front_text' => 'required|string',
            'back_text' => 'nullable|string',
            'example' => 'nullable|string',
            'audio_url' => 'nullable|string',
        ]);

        $card = Flashcard::create($validated);
        return response()->json($card, 201);
    }

    public function show($id)
    {
        return response()->json(Flashcard::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $card = Flashcard::findOrFail($id);
        $card->update($request->only(['front_text','back_text','example','audio_url']));
        return response()->json($card);
    }

    public function destroy($id)
    {
        $card = Flashcard::findOrFail($id);
        $card->delete();
        return response()->json(['message' => 'Deleted']);
    }
}

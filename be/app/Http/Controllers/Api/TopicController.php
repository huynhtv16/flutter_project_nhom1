<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Topic;
use Illuminate\Http\Request;

class TopicController extends Controller
{
    public function index()
    {
        return response()->json(Topic::with('flashcards')->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string',
            'description' => 'nullable|string',
            'cover_image' => 'nullable|string',
        ]);

        $topic = Topic::create($validated);
        return response()->json($topic, 201);
    }

    public function show($id)
    {
        return response()->json(Topic::with('flashcards')->findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $topic = Topic::findOrFail($id);
        $topic->update($request->only(['title','description','cover_image']));
        return response()->json($topic);
    }

    public function destroy($id)
    {
        $topic = Topic::findOrFail($id);
        $topic->delete();
        return response()->json(['message' => 'Deleted']);
    }
}

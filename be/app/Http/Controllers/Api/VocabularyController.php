<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Vocabulary;
use Illuminate\Http\Request;

class VocabularyController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = Vocabulary::query();

        if ($request->has('lesson_id')) {
            $lesson = \App\Models\Lesson::find($request->lesson_id);
            if ($lesson && $lesson->vocabulary_ids) {
                $query->whereIn('id', $lesson->vocabulary_ids);
            }
        }

        $vocabulary = $query->paginate(20);

        return response()->json($vocabulary);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'word' => 'required|string',
            'phonetic' => 'nullable|string',
            'meaning' => 'required|string',
            'examples' => 'nullable|array',
            'image_url' => 'nullable|url',
            'icon' => 'nullable|string',
        ]);

        $vocabulary = Vocabulary::create($validated);

        return response()->json($vocabulary, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Vocabulary $vocabulary)
    {
        return response()->json($vocabulary);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Vocabulary $vocabulary)
    {
        $validated = $request->validate([
            'word' => 'required|string',
            'phonetic' => 'nullable|string',
            'meaning' => 'required|string',
            'examples' => 'nullable|array',
            'image_url' => 'nullable|url',
            'icon' => 'nullable|string',
        ]);

        $vocabulary->update($validated);

        return response()->json($vocabulary);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Vocabulary $vocabulary)
    {
        $vocabulary->delete();

        return response()->json(['message' => 'Vocabulary deleted successfully']);
    }
}

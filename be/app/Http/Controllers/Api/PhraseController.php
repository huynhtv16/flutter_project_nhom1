<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Phrase;
use Illuminate\Http\Request;

class PhraseController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = Phrase::query();

        if ($request->has('lesson_id')) {
            $lesson = \App\Models\Lesson::find($request->lesson_id);
            if ($lesson && $lesson->phrase_ids) {
                $query->whereIn('id', $lesson->phrase_ids);
            }
        }

        $phrases = $query->paginate(20);

        return response()->json($phrases);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'phrase' => 'required|string',
            'meaning' => 'required|string',
            'example' => 'nullable|string',
            'category' => 'nullable|string',
        ]);

        $phrase = Phrase::create($validated);

        return response()->json($phrase, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Phrase $phrase)
    {
        return response()->json($phrase);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Phrase $phrase)
    {
        $validated = $request->validate([
            'phrase' => 'required|string',
            'meaning' => 'required|string',
            'example' => 'nullable|string',
            'category' => 'nullable|string',
        ]);

        $phrase->update($validated);

        return response()->json($phrase);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Phrase $phrase)
    {
        $phrase->delete();

        return response()->json(['message' => 'Phrase deleted successfully']);
    }
}

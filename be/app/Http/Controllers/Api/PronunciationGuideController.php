<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\PronunciationGuide;
use Illuminate\Http\Request;

class PronunciationGuideController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = PronunciationGuide::query();

        if ($request->has('lesson_id')) {
            $lesson = \App\Models\Lesson::find($request->lesson_id);
            if ($lesson && $lesson->pronunciation_ids) {
                $query->whereIn('id', $lesson->pronunciation_ids);
            }
        }

        return response()->json($query->get());
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'symbol' => 'required|string',
            'sound' => 'required|string',
            'description' => 'nullable|string',
            'examples' => 'nullable|array',
        ]);

        $guide = PronunciationGuide::create($validated);

        return response()->json($guide, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        return response()->json(PronunciationGuide::findOrFail($id));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $guide = PronunciationGuide::findOrFail($id);

        $validated = $request->validate([
            'symbol' => 'required|string',
            'sound' => 'required|string',
            'description' => 'nullable|string',
            'examples' => 'nullable|array',
        ]);

        $guide->update($validated);

        return response()->json($guide);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $guide = PronunciationGuide::findOrFail($id);
        $guide->delete();

        return response()->json(['message' => 'Pronunciation guide deleted successfully']);
    }
}

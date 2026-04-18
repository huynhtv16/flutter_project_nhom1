<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Lesson;
use App\Models\Vocabulary;
use App\Models\Phrase;
use App\Models\Exercise;
use Illuminate\Http\Request;

class LessonController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = Lesson::query();

        if ($request->has('type')) {
            $query->where('type', $request->type);
        }

        $lessons = $query->with(['quizzes'])->get();

        return response()->json($lessons);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string',
            'description' => 'nullable|string',
            'type' => 'required|string',
            'vocabulary_ids' => 'nullable|array',
            'phrase_ids' => 'nullable|array',
            'exercise_ids' => 'nullable|array',
        ]);

        $lesson = Lesson::create($validated);

        return response()->json($lesson, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Lesson $lesson)
    {
        $lesson->load(['quizzes.questions.options']);

        // Load related content
        $vocabulary = [];
        if ($lesson->vocabulary_ids) {
            $vocabulary = Vocabulary::whereIn('id', $lesson->vocabulary_ids)->get();
        }

        $phrases = [];
        if ($lesson->phrase_ids) {
            $phrases = Phrase::whereIn('id', $lesson->phrase_ids)->get();
        }

        $exercises = [];
        if ($lesson->exercise_ids) {
            $exercises = Exercise::whereIn('id', $lesson->exercise_ids)->get();
        }

        return response()->json([
            'lesson' => $lesson,
            'vocabulary' => $vocabulary,
            'phrases' => $phrases,
            'exercises' => $exercises,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Lesson $lesson)
    {
        $validated = $request->validate([
            'title' => 'required|string',
            'description' => 'nullable|string',
            'type' => 'required|string',
            'vocabulary_ids' => 'nullable|array',
            'phrase_ids' => 'nullable|array',
            'exercise_ids' => 'nullable|array',
        ]);

        $lesson->update($validated);

        return response()->json($lesson);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Lesson $lesson)
    {
        $lesson->delete();

        return response()->json(['message' => 'Lesson deleted successfully']);
    }
}

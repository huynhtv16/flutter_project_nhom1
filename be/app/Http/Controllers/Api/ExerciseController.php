<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Exercise;
use Illuminate\Http\Request;

class ExerciseController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $exercises = Exercise::all()->map(function ($ex) {
            $qs = $ex->questions;
            if (is_string($qs)) {
                $decoded = json_decode($qs, true);
                $ex->questions = $decoded === null ? [] : $decoded;
            }
            return $ex;
        });

        return response()->json($exercises);
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
            'difficulty' => 'required|integer|min:1|max:5',
            'duration' => 'required|integer|min:1',
            'questions' => 'required|array',
        ]);

        $exercise = Exercise::create($validated);

        return response()->json($exercise, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $ex = Exercise::findOrFail($id);
        if (is_string($ex->questions)) {
            $decoded = json_decode($ex->questions, true);
            $ex->questions = $decoded === null ? [] : $decoded;
        }

        return response()->json($ex);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $exercise = Exercise::findOrFail($id);

        $validated = $request->validate([
            'title' => 'required|string',
            'description' => 'nullable|string',
            'type' => 'required|string',
            'difficulty' => 'required|integer|min:1|max:5',
            'duration' => 'required|integer|min:1',
            'questions' => 'required|array',
        ]);

        $exercise->update($validated);

        return response()->json($exercise);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $exercise = Exercise::findOrFail($id);
        $exercise->delete();

        return response()->json(['message' => 'Exercise deleted successfully']);
    }
}

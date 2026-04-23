<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\LearningPath;
use Illuminate\Http\Request;

class LearningPathController extends Controller
{
    public function index()
    {
        return response()->json(LearningPath::all());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string',
            'description' => 'nullable|string',
            'steps' => 'nullable|array',
        ]);

        $path = LearningPath::create($validated);
        return response()->json($path, 201);
    }

    public function show($id)
    {
        return response()->json(LearningPath::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $path = LearningPath::findOrFail($id);
        $path->update($request->only(['title','description','steps']));
        return response()->json($path);
    }

    public function destroy($id)
    {
        $path = LearningPath::findOrFail($id);
        $path->delete();
        return response()->json(['message' => 'Deleted']);
    }
}

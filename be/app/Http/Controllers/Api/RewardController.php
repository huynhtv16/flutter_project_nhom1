<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Reward;
use Illuminate\Http\Request;

class RewardController extends Controller
{
    public function index()
    {
        return response()->json(Reward::all());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string',
            'description' => 'nullable|string',
            'points' => 'required|integer',
            'icon' => 'nullable|string',
        ]);

        $reward = Reward::create($validated);
        return response()->json($reward, 201);
    }

    public function show($id)
    {
        return response()->json(Reward::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $reward = Reward::findOrFail($id);
        $reward->update($request->only(['title','description','points','icon']));
        return response()->json($reward);
    }

    public function destroy($id)
    {
        $reward = Reward::findOrFail($id);
        $reward->delete();
        return response()->json(['message' => 'Deleted']);
    }
}

<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ListeningItem;
use Illuminate\Http\Request;

class ListeningItemController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $query = ListeningItem::query();
        if (request()->has('course_id')) {
            $query->where('course_id', request('course_id'));
        }

        return response()->json($query->get());
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string',
            'text' => 'required|string',
            'course_id' => 'nullable|integer|exists:courses,id',
        ]);

        $item = ListeningItem::create($validated);

        return response()->json($item, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        return response()->json(ListeningItem::findOrFail($id));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $item = ListeningItem::findOrFail($id);

        $validated = $request->validate([
            'title' => 'required|string',
            'text' => 'required|string',
            'course_id' => 'nullable|integer|exists:courses,id',
        ]);

        $item->update($validated);

        return response()->json($item);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $item = ListeningItem::findOrFail($id);
        $item->delete();

        return response()->json(['message' => 'Listening item deleted']);
    }
}

<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\UserProgress;
use Illuminate\Http\Request;

class ProgressController extends Controller
{
    /**
     * Get user progress
     */
    public function show(Request $request)
    {
        $progress = $request->user()->progress;

        if (!$progress) {
            $progress = UserProgress::create(['user_id' => $request->user()->id]);
        }

        return response()->json($progress);
    }

    /**
     * Add learned word
     */
    public function addLearnedWord(Request $request)
    {
        $request->validate([
            'word_id' => 'required|integer|exists:vocabulary,id',
        ]);

        $progress = $request->user()->progress;
        if (!$progress) {
            $progress = UserProgress::create(['user_id' => $request->user()->id]);
        }

        $learnedWords = $progress->learned_words ?? [];
        if (!in_array($request->word_id, $learnedWords)) {
            $learnedWords[] = $request->word_id;
            $progress->update(['learned_words' => $learnedWords]);
        }

        return response()->json($progress);
    }

    /**
     * Toggle favorite word
     */
    public function toggleFavorite(Request $request)
    {
        $request->validate([
            'word_id' => 'required|integer|exists:vocabulary,id',
        ]);

        $progress = $request->user()->progress;
        if (!$progress) {
            $progress = UserProgress::create(['user_id' => $request->user()->id]);
        }

        $favorites = $progress->favorites ?? [];
        $wordId = $request->word_id;

        if (in_array($wordId, $favorites)) {
            $favorites = array_diff($favorites, [$wordId]);
        } else {
            $favorites[] = $wordId;
        }

        $progress->update(['favorites' => array_values($favorites)]);

        return response()->json($progress);
    }

    /**
     * Get user statistics
     */
    public function stats(Request $request)
    {
        $user = $request->user();
        $progress = $user->progress;

        $stats = [
            'total_learned_words' => count($progress->learned_words ?? []),
            'total_quiz_attempts' => $user->quizAttempts()->count(),
            'total_exercise_attempts' => $user->exerciseAttempts()->count(),
            'average_quiz_score' => $user->quizAttempts()->avg('score') ?? 0,
            'total_score' => $progress->total_score ?? 0,
            'favorite_words_count' => count($progress->favorites ?? []),
        ];

        return response()->json($stats);
    }
}

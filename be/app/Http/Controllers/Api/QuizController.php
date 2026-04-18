<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Quiz;
use App\Models\QuizAttempt;
use Illuminate\Http\Request;

class QuizController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $quizzes = Quiz::with(['lesson', 'questions.options'])->get();

        return response()->json($quizzes);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string',
            'lesson_id' => 'nullable|exists:lessons,id',
            'questions' => 'required|array',
            'questions.*.question' => 'required|string',
            'questions.*.options' => 'required|array|min:2',
            'questions.*.correct_answer_index' => 'required|integer|min:0',
            'questions.*.explanation' => 'nullable|string',
        ]);

        $quiz = Quiz::create([
            'title' => $validated['title'],
            'lesson_id' => $validated['lesson_id'] ?? null,
        ]);

        foreach ($validated['questions'] as $questionData) {
            $question = $quiz->questions()->create([
                'question' => $questionData['question'],
                'correct_answer_index' => $questionData['correct_answer_index'],
                'explanation' => $questionData['explanation'] ?? null,
            ]);

            foreach ($questionData['options'] as $index => $optionText) {
                $question->options()->create([
                    'option_text' => $optionText,
                    'position' => $index,
                ]);
            }
        }

        return response()->json($quiz->load('questions.options'), 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Quiz $quiz)
    {
        return response()->json($quiz->load(['lesson', 'questions.options']));
    }

    /**
     * Submit quiz answers and calculate score
     */
    public function submit(Request $request, Quiz $quiz)
    {
        $validated = $request->validate([
            'answers' => 'required|array',
            'answers.*' => 'integer|min:0',
        ]);

        $questions = $quiz->questions()->with('options')->get();
        $score = 0;
        $totalQuestions = $questions->count();

        foreach ($questions as $index => $question) {
            $userAnswer = $validated['answers'][$index] ?? null;
            if ($userAnswer === $question->correct_answer_index) {
                $score++;
            }
        }

        // Record attempt
        QuizAttempt::create([
            'user_id' => $request->user()->id,
            'quiz_id' => $quiz->id,
            'score' => $score,
            'attempted_at' => now(),
        ]);

        // Update user progress
        $progress = $request->user()->progress;
        if ($progress) {
            $quizScores = $progress->quiz_scores ?? [];
            $quizScores[] = [
                'quiz_id' => $quiz->id,
                'score' => $score,
                'total' => $totalQuestions,
                'attempted_at' => now(),
            ];
            $progress->update([
                'quiz_scores' => $quizScores,
                'total_score' => ($progress->total_score ?? 0) + $score,
            ]);
        }

        return response()->json([
            'score' => $score,
            'total' => $totalQuestions,
            'percentage' => round(($score / $totalQuestions) * 100, 2),
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Quiz $quiz)
    {
        $validated = $request->validate([
            'title' => 'required|string',
            'lesson_id' => 'nullable|exists:lessons,id',
        ]);

        $quiz->update($validated);

        return response()->json($quiz);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Quiz $quiz)
    {
        $quiz->delete();

        return response()->json(['message' => 'Quiz deleted successfully']);
    }
}

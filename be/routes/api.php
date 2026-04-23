<?php

use App\Http\Controllers\Api\ExerciseController;
use App\Http\Controllers\Api\CourseController;
use App\Http\Controllers\Api\ListeningItemController;
use App\Http\Controllers\Api\LessonController;
use App\Http\Controllers\Api\PhraseController;
use App\Http\Controllers\Api\ProgressController;
use App\Http\Controllers\Api\PronunciationGuideController;
use App\Http\Controllers\Api\QuizController;
use App\Http\Controllers\Api\VocabularyController;
use App\Http\Controllers\Api\TopicController;
use App\Http\Controllers\Api\FlashcardController;
use App\Http\Controllers\Api\RewardController;
use App\Http\Controllers\Api\LearningPathController;
use App\Http\Controllers\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Auth routes
Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);
Route::post('/logout', [AuthController::class, 'logout']);
Route::get('/user', [AuthController::class, 'user']);

// Public API routes for quick testing
Route::apiResource('courses', CourseController::class);
Route::apiResource('listening-items', ListeningItemController::class);
Route::apiResource('lessons', LessonController::class);
Route::apiResource('vocabulary', VocabularyController::class);
Route::apiResource('quizzes', QuizController::class);
Route::post('quizzes/{quiz}/submit', [QuizController::class, 'submit']);
Route::apiResource('exercises', ExerciseController::class);
Route::apiResource('phrases', PhraseController::class);
Route::apiResource('pronunciation-guides', PronunciationGuideController::class);
Route::apiResource('topics', TopicController::class);
Route::apiResource('flashcards', FlashcardController::class);
Route::apiResource('rewards', RewardController::class);
Route::post('rewards/{reward}/claim', [\App\Http\Controllers\Api\RewardClaimController::class, 'claim']);
Route::apiResource('learning-paths', LearningPathController::class);
Route::get('progress', [ProgressController::class, 'show']);
Route::post('progress/learned-words', [ProgressController::class, 'addLearnedWord']);
Route::post('progress/favorites', [ProgressController::class, 'toggleFavorite']);
Route::get('progress/stats', [ProgressController::class, 'stats']);
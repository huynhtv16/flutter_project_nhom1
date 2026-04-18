<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\UserProgress;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'username' => 'required|string',
            'password' => 'required|string',
        ]);

        $user = User::where('name', $request->username)->first();

        if (! $user || ! Hash::check($request->password, $user->password)) {
            return response()->json(['message' => 'Invalid credentials'], 401);
        }

        $progress = UserProgress::firstOrCreate(['user_id' => $user->id]);

        return response()->json([
            'user' => $user,
            'progress' => $progress,
            'token' => bin2hex(random_bytes(40)),
        ]);
    }

    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string|unique:users',
            'email' => 'required|string|email|unique:users',
            'password' => 'required|string|min:8',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        // Create user progress
        UserProgress::create(['user_id' => $user->id]);

        return response()->json([
            'user' => $user,
            'progress' => $user->progress,
            'token' => bin2hex(random_bytes(40)),
        ], 201);
    }

    public function logout(Request $request)
    {
        return response()->json(['message' => 'Logged out successfully']);
    }

    public function user(Request $request)
    {
        $user = $request->user();

        if (! $user) {
            return response()->json(['message' => 'No authenticated user'], 401);
        }

        return response()->json([
            'user' => $user,
            'progress' => $user->progress,
        ]);
    }
}
